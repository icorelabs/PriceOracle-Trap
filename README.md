# TrapPriceOracle

`TrapPriceOracle` is a **Trap contract** for the Drosera ecosystem.  
This contract monitors prices from a **price feed** (e.g., `PriceResponseMock`) and gets triggered if the price crosses a defined `THRESHOLD`.

---

## ✨ Key Features
- Implements Drosera’s `ITrap` interface.
- Reads the latest price from a responder/oracle (`latestAnswer()`).
- Checks price condition against a threshold (either **above** or **below**).
- Provides a standard `oracleRespond()` function for Drosera compatibility.

---

## 📂 Structure
- `src/TrapPriceOracle.sol` → the main trap contract.
- `src/PriceResponseMock.sol` → a simple mock oracle contract (for testing purposes).

---

## ⚙️ How It Works
1. **PriceResponseMock** stores a manually set price.
   - `setPrice(int256 _price)` → updates the price.
   - `latestAnswer()` → returns the latest price.

2. **TrapPriceOracle** reads the price from `PriceResponseMock`.
   - `collect()` → gathers data (price + threshold + condition above/below).
   - `shouldRespond(bytes[] data)` → decides whether the trap should trigger.

3. If the condition matches, Drosera triggers the response via `oracleRespond()`.

---
