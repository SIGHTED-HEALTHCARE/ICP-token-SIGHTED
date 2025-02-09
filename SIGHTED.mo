import Nat "mo:base/Nat";
import Principal "mo:base/Principal";

actor SIGHTED {
  stable var balances: Trie.Trie<Principal, Nat> = Trie.empty();

  public func mint(to: Principal, amount: Nat): async Bool {
    let currentBalance = Trie.get(balances, to) ?: 0;
    balances := Trie.put(balances, to, currentBalance + amount);
    return true;
  };

  public func transfer(to: Principal, amount: Nat): async Bool {
    let caller = Principal.fromActor(this);
    let currentBalance = Trie.get(balances, caller) ?: 0;

    if (currentBalance < amount) {
      return false;
    };

    balances := Trie.put(balances, caller, currentBalance - amount);
    let recipientBalance = Trie.get(balances, to) ?: 0;
    balances := Trie.put(balances, to, recipientBalance + amount);
    return true;
  };

  public query func balance_of(owner: Principal): async Nat {
    return Trie.get(balances, owner) ?: 0;
  };
}
