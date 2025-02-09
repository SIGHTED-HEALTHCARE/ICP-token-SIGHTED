import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Trie "mo:base/Trie";

actor SIGHTED {
  stable var balances: Trie.Trie<Principal, Nat> = Trie.empty();

  /// Mint new tokens for a specific user
  public func mint(to: Principal, amount: Nat): async Bool {
    let currentBalance = Trie.get(balances, to) ?: 0;
    balances := Trie.put(balances, to, currentBalance + amount);
    return true;
  };

  /// Transfer tokens from the caller to a recipient
  public func transfer(to: Principal, amount: Nat): async Bool {
    let caller = Principal.fromActor(this);
    let currentBalance = Trie.get(balances, caller) ?: 0;

    if (currentBalance < amount) {
      return false;  // Insufficient balance
    };

    balances := Trie.put(balances, caller, currentBalance - amount);
    let recipientBalance = Trie.get(balances, to) ?: 0;
    balances := Trie.put(balances, to, recipientBalance + amount);
    return true;
  };

  /// Get the balance of a specific user
  public query func balance_of(owner: Principal): async Nat {
    return Trie.get(balances, owner) ?: 0;
  };

  /// Token-gated access: Check if a user has the required token balance for access
  public func has_access(user: Principal, requiredBalance: Nat): async Bool {
    let userBalance = Trie.get(balances, user) ?: 0;
    return userBalance >= requiredBalance;
  };

  /// Verify token ownership (integrating with Calimero's SDK via an external call)
  public func verify_token_ownership(walletAddress: Text, tokenId: Text): async Bool {
    let response = await external_call_to_calimero({
      method: "verify_token",
      args: { "walletAddress": walletAddress; "tokenId": tokenId }
    });
    switch (response) {
      case (#ok(result)) {
        return result.isOwner;
      };
      case (#err(error)) {
        return false;
      };
    };
  };

  // Placeholder for Calimero SDK integration via external HTTP calls
  private func external_call_to_calimero(request: { method: Text; args: { "walletAddress": Text; "tokenId": Text } }): async Result<{ isOwner: Bool }, Text> {
    // In a real implementation, this would send an HTTP request to Calimero's RPC API
    return #ok({ isOwner = true });  // Mock response for demonstration
  };
}
