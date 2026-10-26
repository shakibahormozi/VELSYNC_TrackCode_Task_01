## TimeLock Smart Contract

**Overview**

TimeLock is a simple Ethereum smart contract written in Solidity that allows funds to be locked until a specified amount of time has passed. Only the account that deploys the contract can withdraw the funds, and withdrawals are permitted only after the unlock time has been reached.

This project demonstrates the use of time-based conditions, access control, and Ether transfers in Solidity.

**Features**

- Time-Based Lock: Funds remain locked until the specified unlock time.

- Owner Access Control: Only the contract owner can withdraw funds.

- Remaining Time Calculation: Displays the remaining lock period in days, hours, minutes, and seconds.

- Ether Transfers: Uses Solidity's low-level call method to transfer the contract's balance to the owner.

- Input Flexibility: The lock duration is provided during contract deployment.

**Technologies**

- Solidity 0.8.34

- Remix IDE

- Ethereum Virtual Machine (EVM)

**How It Works**

1. Contract Deployment

The constructor accepts a parameter called _unlockOffset, which represents the lock duration in seconds.

When the contract is deployed, it calculates the unlock timestamp by adding the specified duration to the current block timestamp.

For example, passing 120 as _unlockOffset sets the unlock time approximately two minutes after deployment.

The account that deploys the contract is stored as the owner.

2. Checking the Remaining Time

The getTimeRemaining() function calculates how much time remains before withdrawals are allowed.

It returns four values:

- daysRemaining

- hoursRemaining

- minutesRemaining

- secondsRemaining

If the unlock time has already been reached, the function returns zero for all four values.

This function is read-only and does not modify the blockchain state.

3. Withdrawing Funds

The withdraw() function allows the owner to withdraw the contract's entire Ether balance once the lock period has expired.

It checks that:

1. The current block timestamp is greater than or equal to the unlock timestamp.

2. The caller is the contract owner.

3. The Ether transfer succeeds.

If any requirement fails, the transaction is reverted.


## Main Functions

| Function | Description |
|---|---|
| `constructor(uint _unlockOffset)` | Sets the lock duration and records the owner. |
| `getTimeRemaining()` | Returns the remaining lock time in days, hours, minutes, and seconds. |
| `withdraw()` | Transfers the contract's Ether balance to the owner after unlocking. |



**How to Test in Remix IDE**

1. Open Remix IDE.

2. Create a file named TimeLock.sol and paste the contract code into it.

3. Select Solidity compiler version 0.8.34 and compile the contract.

4. Deploy the contract using Remix VM.

5. Enter a lock duration, such as 120, for a two-minute lock.

6. To fund the contract, enter an Ether amount in the VALUE field before deployment and select wei, gwei, or ether as appropriate.

7. Call getTimeRemaining() to check the remaining time.

8. Try calling withdraw() before the lock expires. The transaction should revert with You can't withdraw yet.

9. After the lock expires, call withdraw() from the owner account.

10. Verify that the contract balance has been transferred to the owner.

**Note:** getTimeRemaining() does not update automatically every second. Call it again to retrieve the latest values. In Remix VM, block timestamps advance according to the test environment and mined transactions, so elapsed time may not behave exactly like a continuously running real-world clock.

**Security Considerations**

- The contract restricts withdrawals to the owner.

- The unlock condition is enforced on-chain using block.timestamp.

- The transfer uses call, and its success status is checked.

- This is an educational project and has not been audited. A production-ready implementation should also consider reentrancy protection, withdrawal-state management, and additional security testing.

**Learning Outcomes**

Through this project, I practiced:

- Writing and compiling Solidity smart contracts.

- Working with constructors, state variables, and access control.

- Using block.timestamp for time-based conditions.

- Calculating time intervals using seconds.

- Receiving and transferring Ether.

- Testing smart contract behavior and handling reverted transactions in Remix IDE.

**Disclaimer**

This project is intended for educational purposes only. It has not been professionally audited and should not be used to secure real funds without further development and security review.
