# PayChain API Documentation

## Overview

The PayChain API provides a comprehensive interface for interacting with the PayChain payment system. This documentation outlines all available endpoints, request/response formats, and authentication requirements.

## Base URL

```plaintext
https://<canister-id>.ic0.app
```plaintext

## Authentication

All API requests require authentication using Internet Identity. Include the following header:

All API requests require authentication using Internet Identity. Include the following header:

https://<canister-id>.ic0.app

```plaintext

## Endpoints

### Payment Operations

#### Process Payment

```http
POST /api/payments
```plaintext

Request:

```json
{
  "amount": "1000000000", // Amount in e8s (0.1 ICP)
  "recipient": "principal-id"
}
```

Response:

```json
{
  "id": "123",
  "amount": "1000000000",
  "sender": "principal-id",
  "recipient": "principal-id",
  "timestamp": 1634567890,
  "status": "completed"
}
```

### Get Balance

```http
GET /api/balance
```

Response:

```json
{
  "balance": "5000000000" // Balance in e8s (0.5 ICP)
}
```

### Transaction Management

#### Get Transactions

```http
GET /api/transactions
```

Query Parameters:

- `page`: Page number (default: 1)
- `limit`: Items per page (default: 10)
- `status`: Filter by status
- `startDate`: Start date timestamp
- `endDate`: End date timestamp

```json
{
  "transactions": [
    {
      "id": "123",
      "amount": "1000000000",
      "sender": "principal-id",
      "recipient": "principal-id",
      "timestamp": 1634567890,
      "status": "completed"
    }
  ],
  "total": 100,
  "page": 1,
  "limit": 10
}
```

#### Get Transaction by ID

```http
GET /api/transactions/{id}
```

Response:

```json
{
  "id": "123",
  "amount": "1000000000",
  "sender": "principal-id",
  "recipient": "principal-id",
  "timestamp": 1634567890,
  "status": "completed"
}
```

### NFT Receipts

#### Get NFT Receipt

```http
GET /api/receipts/{transactionId}
```

Response:

```json
{
  "id": "123",
  "transactionId": "456",
  "metadata": {
    "name": "Payment Receipt",
    "description": "Payment of 0.1 ICP",
    "image": "data:image/svg+xml,..."
  },
  "createdAt": 1634567890
}
```

### Security

#### Get Security Status

```http
GET /api/security/status
```

Response:

```json
{
  "rateLimit": {
    "current": 5,
    "limit": 100,
    "reset": 1634567890
  },
  "threats": [],
  "ipStatus": "allowed"
}
```

#### Report Security Issue

```http
POST /api/security/report
```

Request:

```json
{
  "type": "suspicious_activity",
  "description": "Multiple failed login attempts",
  "timestamp": 1634567890
}
```

### Analytics

#### Get Transaction Analytics

```http
GET /api/analytics/transactions
```

Query Parameters:

- `startDate`: Start date timestamp
- `endDate`: End date timestamp
- `groupBy`: "day" | "week" | "month"

Response:

```json
{
  "totalTransactions": 100,
  "totalVolume": "50000000000",
  "averageAmount": "500000000",
  "timeDistribution": [
    {
      "period": "2023-10-01",
      "count": 10,
      "volume": "5000000000"
    }
  ]
}
```

#### Get System Health

```http
GET /api/analytics/health
```

Response:

```json
{
  "uptime": 99.99,
  "errorRate": 0.01,
  "responseTime": 150,
  "activeUsers": 1000
}
```

### Error Handling

All endpoints may return the following error responses:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Error description",
    "details": "Additional error details"
  }
}
```

Common Error Codes:

- `AUTH_REQUIRED`: Authentication required
- `INVALID_INPUT`: Invalid request parameters
- `INSUFFICIENT_FUNDS`: Insufficient balance
- `RATE_LIMIT_EXCEEDED`: Rate limit exceeded
- `TRANSACTION_FAILED`: Transaction processing failed
- `SYSTEM_ERROR`: Internal system error

## Rate Limiting

- 100 requests per minute per IP
- 1000 requests per hour per user
- Rate limit headers included in responses:

  ```
  X-RateLimit-Limit: 100
  X-RateLimit-Remaining: 95
  X-RateLimit-Reset: 1634567890
  ```

## WebSocket API

### Connection

```
wss://<canister-id>.ic0.app/ws
```

### WebSocket Events Overview

### WebSocket Events Overview

### Events

### WebSocket Events

1. Transaction Updates

2. Balance Updates

```json
{
  "type": "balance",
  "data": {
    "balance": "5000000000"
  }
}
```

1. Security Alerts

```json
{
  "type": "security_alert",
  "data": {
    "type": "suspicious_activity",
    "severity": "high"
  }
}
```

## SDK Examples

### TypeScript/JavaScript

```typescript
import { PayChainClient } from '@paychain/sdk';

const client = new PayChainClient({
  canisterId: 'your-canister-id'
});

// Process payment
const transaction = await client.processPayment({
  amount: '1000000000',
  recipient: 'principal-id'
});

// Get balance
const balance = await client.getBalance();

// Subscribe to updates
client.subscribe('transaction', (data) => {
  console.log('New transaction:', data);
});

// User interface example
interface User {
  id: number;
  name: string;
}
```

### Python

```python
from paychain_sdk import PayChainClient

client = PayChainClient(canister_id='your-canister-id')

# Process payment
transaction = client.process_payment(
    amount='1000000000',
    recipient='principal-id'
)

# Get balance
balance = client.get_balance()

# Subscribe to updates
client.subscribe('transaction', lambda data: print('New transaction:', data))
```

### JavaScript

```javascript
// Your code here
```

### Build Instructions

```bash
npm install
npm run build
```

## Versioning

The API is versioned through the URL path:

- Current version: `/api/v1/`
- Legacy version: `/api/v0/`

## Support

For API support:

- Email: <support@paychain.com>
- Documentation: [https://docs.paychain.com](https://docs.paychain.com)
- GitHub Issues: [https://github.com/paychain/issues](https://github.com/paychain/issues)- GitHub Issues: [https://github.com/paychain/issues](https://github.com/paychain/issues)
