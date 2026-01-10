using Identity.Application.Services;
using Identity.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Identity.API.Controllers;

[ApiController]
[Route("api/identity/v1/[controller]")]
public class AuthController : ControllerBase
{
    private readonly IdentityDbContext _context;
    private readonly ITokenService _tokenService;
    private readonly ILogger<AuthController> _logger;

    public AuthController(
        IdentityDbContext context,
        ITokenService tokenService,
        ILogger<AuthController> logger)
    {
        _context = context;
        _tokenService = tokenService;
        _logger = logger;
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        var user = await _context.Users
            .FirstOrDefaultAsync(u => u.Email == request.Email.ToLowerInvariant());

        if (user == null || !user.ValidatePassword(request.Password))
        {
            return Unauthorized(new { message = "Invalid email or password" });
        }

        if (!user.IsActive)
        {
            return Unauthorized(new { message = "Account is inactive" });
        }

        user.RecordLogin();
        await _context.SaveChangesAsync();

        var token = _tokenService.GenerateToken(user);

        _logger.LogInformation("User {UserId} logged in successfully", user.Id);

        return Ok(new LoginResponse
        {
            Token = token,
            UserId = user.Id,
            Email = user.Email,
            FullName = $"{user.FirstName} {user.LastName}".Trim(),
            Roles = user.Roles.ToList()
        });
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request)
    {
        if (await _context.Users.AnyAsync(u => u.Email == request.Email.ToLowerInvariant()))
        {
            return BadRequest(new { message = "Email already registered" });
        }

        // Get default tenant or create one
        var tenant = await _context.Tenants.FirstOrDefaultAsync(t => t.Slug == "default");
        if (tenant == null)
        {
            return BadRequest(new { message = "No tenant available" });
        }

        var user = Domain.Entities.User.Create(
            tenant.Id,
            request.Email,
            request.Username ?? request.Email,
            request.Password,
            request.FirstName,
            request.LastName
        );

        _context.Users.Add(user);
        await _context.SaveChangesAsync();

        var token = _tokenService.GenerateToken(user);

        _logger.LogInformation("New user registered: {UserId}", user.Id);

        return CreatedAtAction(nameof(GetProfile), new { id = user.Id }, new LoginResponse
        {
            Token = token,
            UserId = user.Id,
            Email = user.Email,
            FullName = $"{user.FirstName} {user.LastName}".Trim(),
            Roles = user.Roles.ToList()
        });
    }

    [HttpGet("profile/{id}")]
    public async Task<IActionResult> GetProfile(Guid id)
    {
        var user = await _context.Users.FindAsync(id);
        
        if (user == null)
        {
            return NotFound();
        }

        return Ok(new
        {
            user.Id,
            user.Email,
            user.Username,
            user.FirstName,
            user.LastName,
            user.Roles,
            user.IsActive,
            user.EmailConfirmed,
            user.CreatedAt,
            user.LastLoginAt
        });
    }
}

public record LoginRequest(string Email, string Password);

public record RegisterRequest(
    string Email,
    string Password,
    string FirstName,
    string LastName,
    string? Username = null);

public record LoginResponse
{
    public string Token { get; init; } = string.Empty;
    public Guid UserId { get; init; }
    public string Email { get; init; } = string.Empty;
    public string FullName { get; init; } = string.Empty;
    public List<string> Roles { get; init; } = new();
}
