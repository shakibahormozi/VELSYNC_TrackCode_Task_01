 ## Blockchain Incident Registry

A beginner-friendly smart contract project built with Solidity and tested using the Remix IDE.

**Overview**  

The Blockchain Incident Registry is an educational smart contract prototype designed to register and track reports associated with blockchain transactions.  

It allows authorized analysts to submit reports, assign risk levels, and update investigation statuses. Each report receives a unique ID and includes a transaction hash and an evidence hash for reference.  

**Important:** This project does not automatically scan blockchain transactions, detect illicit activity, or verify whether a report is accurate. It is an educational prototype, not a production investigation or risk-detection system.  

**Features**  

- Register reports associated with blockchain transactions.

- Assign a risk level from 1 to 5.

- Track report statuses: Open, UnderReview, Resolved, and FalsePositive.

- Restrict report creation and status updates to authorized analysts.

- Allow the contract owner to manage analyst permissions.

- Prevent duplicate reports using the same transaction hash.

- Emit events when analyst permissions or report statuses change.

- Retrieve report details using a report ID.

**Technologies**

- Solidity ^0.8.20

- Ethereum smart contracts

- Remix IDE

- Remix VM for simulated testing

- GitHub for source code and documentation

**Project Structure**

Blockchain-Incident-Registry/  
├── IncidentRegistry.sol  
├── README.md  
├── TESTING.md  
├── LEARNINGS.md  
└── screenshots/  

How It Works

The contract deployer becomes the owner and an authorized analyst.

The owner can authorize or revoke analysts.

An authorized analyst can create a report containing a subject address, transaction hash, evidence hash, and risk level.

The contract assigns a unique report ID and initializes its status as Open.

Authorized analysts can update the report status.

Anyone can call the read-only getReport function to retrieve report details.

Testing

The contract was compiled and deployed using Remix IDE's simulated Remix VM environment.

The following scenarios were tested:

Successful contract deployment.

Verification of the owner and analyst permissions.

Successful creation and retrieval of a report.

Successful status update from Open to UnderReview.

Rejection of report creation by an unauthorized account.

Rejection of a duplicate transaction hash.

See TESTING.md for more details.

Security and Limitations

The project uses synthetic test data.

Data stored on a public blockchain may be visible to others.

Hashes do not automatically guarantee confidentiality or prove that evidence is authentic.

Risk levels are supplied by the analyst; they are not calculated automatically.

The prototype has not been audited and is not intended for production use.

Testing was performed in Remix VM; the contract has not been deployed to a public blockchain.

Learning Objectives

This project explores Solidity fundamentals, smart contract deployment, role-based access control, mappings, structs, enums, events, transaction validation, and basic security testing.

License

This project is shared for educational purposes.
