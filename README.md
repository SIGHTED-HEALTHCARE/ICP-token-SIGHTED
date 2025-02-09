# **SIGHTED Token (ICP & Calimero Integration)**  

SIGHTED Token is a **fungible token** on the **Internet Computer Protocol (ICP)** designed for secure, privacy-centric applications. This project integrates the **Calimero TypeScript SDK** in the frontend to enable private data management, token-gated access, and real-time updates.

---

## **Features**
- **Fungible Token on ICP**: Mint, transfer, and verify token balances on ICP.
- **Private Data Management**: Use Calimero’s private shards for data storage and Zero-Knowledge Proofs (ZKPs).
- **Token-Gated Access**: Require SIGHTED token ownership for accessing premium features.
- **Real-Time Updates**: Powered by Calimero SDK’s WebSocket support for seamless data synchronization.

---

## **Installation**
### Prerequisites
- **Node.js** (>= 14.x)  
- **DFX CLI** (for deploying ICP canisters)  
  [Install DFX](https://internetcomputer.org/docs/current/developer-docs/setup/install/)

### Clone the Repository
```bash
git clone https://github.com/your-repo/sighted-token-icp.git
cd sighted-token-icp
```

### Install Dependencies
```bash
npm install
```

---

## **Deployment**
### Deploying the ICP Token Canister
1. **Start the DFX local replica**  
   ```bash
   dfx start --background
   ```
2. **Build and deploy the canister**  
   ```bash
   dfx deploy
   ```

---

## **Frontend Integration with Calimero SDK**
To manage **authentication**, **RPC communication**, and **real-time updates**, integrate the **Calimero TypeScript SDK** in your React-based frontend.

### Example Structure
1. **Authentication & Token Management**
```typescript
import { ClientLogin, AccessTokenWrapper } from '@calimero-network/calimero-client';

const LoginPage = () => (
  <ClientLogin
    getNodeUrl={() => process.env.NEXT_PUBLIC_API_URL}
    getApplicationId={() => process.env.NEXT_PUBLIC_APPLICATION_ID}
    successRedirect={() => (window.location.href = '/dashboard')}
  />
);

const App = () => (
  <AccessTokenWrapper getNodeUrl={() => process.env.NEXT_PUBLIC_API_URL}>
    <YourApp />
  </AccessTokenWrapper>
);
```

2. **Token-Based Access Control**
Check the user’s ICP token balance and grant access if the balance meets the requirement.
```typescript
const checkTokenAccess = async (userId) => {
  const response = await rpcClient.execute({
    applicationId: process.env.NEXT_PUBLIC_APPLICATION_ID,
    method: 'get_token_balance',
    argsJson: { userId },
  });

  if (response.balance >= 100) {
    console.log('Access granted');
    window.location.href = '/dashboard';
  } else {
    console.log('Access denied');
  }
};
```

---

## **Use Cases for ICP Token Integration**
1. **Token-Based Dashboard Access**: Require users to hold a minimum number of ICP tokens to access premium features.
2. **Token Rewards for Data Sharing**: Incentivize users to share anonymized data by rewarding them with SIGHTED tokens.

### Example: Token Verification
```typescript
const verifyTokenOwnership = async (walletAddress) => {
  const response = await rpcClient.execute({
    applicationId: process.env.NEXT_PUBLIC_APPLICATION_ID,
    method: 'verify_token',
    argsJson: { walletAddress, tokenId: 'your-token-id' },
  });

  return response.isOwner;
};
```

---

## **Development**
### Build and Test
1. **Build the contract**  
   ```bash
   dfx build
   ```
2. **Run tests**  
   ```bash
   dfx test
   ```
