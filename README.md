## **SIGHTED Token (ICP Token)**

### **Overview**
SIGHTED Token is a fungible token deployed on the **Internet Computer Protocol (ICP)**. It adheres to the **ICP Ledger standard**, enabling secure, scalable, and low-cost transactions for decentralized applications.

---

### **Features**
- **Fungible Token**: Supports standard operations such as minting, transferring, and checking balances.
- **Ledger-Based**: Built using ICP's native **Ledger Canister** for transaction recording.
- **Cross-Chain Ready**: Designed for future compatibility with Ethereum and other networks.
- **Secure and Scalable**: Leverages ICP’s decentralized infrastructure.

---

### **Installation**
1. **Install DFX CLI**  
   Follow the [Internet Computer documentation](https://internetcomputer.org/docs/current/developer-docs/setup/install/) to set up your DFX environment.

2. **Clone the Repository**
   ```bash
   git clone https://github.com/your-repo/sighted-token-icp.git
   cd sighted-token-icp
   ```

3. **Build and Deploy**  
   Run the following commands:
   ```bash
   dfx start --background
   dfx deploy
   ```

---

### **Usage**
#### Mint Tokens
```bash
dfx canister call sighted_token mint '(principal "receiver-principal-id", 1000)'
```

#### Transfer Tokens
```bash
dfx canister call sighted_token transfer '(principal "receiver-principal-id", 500)'
```

#### Check Balance
```bash
dfx canister call sighted_token balance_of '(principal "receiver-principal-id")'
```
---

### **Development**
1. **Build the Token Contract**
   ```bash
   dfx build
   ```

2. **Run Tests**
   ```bash
   dfx test
   ```
