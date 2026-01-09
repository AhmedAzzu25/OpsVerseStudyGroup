# Healthcare Module: Offline-First Clinic App

## Context
Build a **Progressive Web App (PWA)** for clinics in low-connectivity regions of Africa. The app must work fully offline and sync data when internet is available.

## Tech Stack
- **React 18** with TypeScript
- **PouchDB** for local storage
- **Azure Functions** (Node.js/Python) for sync backend
- **Azure Cosmos DB** for cloud storage
- **Workbox** for Service Worker management

## Architecture Requirements

### Frontend (React PWA)
1. **Patient Management**
   - Register new patients
   - View patient history
   - Update patient records

2. **Offline Storage**
   - PouchDB stores all patient data locally
   - Automatic conflict resolution (last-write-wins or custom)

3. **Service Worker**
   - Cache app shell and static assets
   - Background sync for data uploads
   - Push notifications for reminders

### Backend (Azure Functions)
1. **Sync Function** (HTTP Trigger)
   - Receives PouchDB changes from client
   - Writes to Cosmos DB
   - Returns server-side changes

2. **Conflict Resolution**
   - Timestamp-based merging
   - Manual review queue for critical conflicts

## Key Implementation Tasks

### 1. Initialize React PWA
```bash
npx create-react-app healthcare-app --template typescript
npm install pouchdb pouchdb-find workbox-webpack-plugin
```

### 2. Configure Service Worker
Update `src/service-worker.js` to:
- Cache static resources (HTML, CSS, JS)
- Implement background sync for POST requests
- Handle offline/online events

### 3. PouchDB Integration
```typescript
import PouchDB from 'pouchdb';

const localDB = new PouchDB('clinic_db');
const remoteDB = new PouchDB('https://your-cosmos-db-url');

// Bidirectional sync
localDB.sync(remoteDB, { live: true, retry: true });
```

### 4. Azure Function Sync Endpoint
```javascript
module.exports = async function (context, req) {
    const changes = req.body.docs;
    
    // Write to Cosmos DB
    await container.items.bulk(changes);
    
    // Return server changes
    const serverChanges = await getChangesSince(req.body.lastSeq);
    context.res = { body: serverChanges };
};
```

### 5. Patient Form Component
Build a React component with:
- Form validation (React Hook Form)
- Local save to PouchDB
- Sync status indicator (syncing/synced/offline)

## Acceptance Criteria
- [ ] App installs as PWA on mobile
- [ ] Full CRUD operations work offline
- [ ] Data syncs automatically when online
- [ ] Conflict resolution logs displayed
- [ ] Service worker caches app for offline use
- [ ] Responsive design (mobile-first)

## Testing Strategy
- Test offline mode (disable network in DevTools)
- Simulate conflicts (edit same record on two devices)
- Verify sync after reconnection

## Getting Started
Execute this plan incrementally. Start with a basic React app, add PouchDB, then implement Service Worker, and finally integrate Azure Functions.

**Remember:** User experience is key—always show sync status clearly!
