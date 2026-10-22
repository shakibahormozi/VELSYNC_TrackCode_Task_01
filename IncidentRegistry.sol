
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.20;

 contract IncidentRegistry {
     address public immutable owner;
     uint256 public nextReportId = 1;

     enum Status {
         Open,
         UnderReview,
         Resolved,
         FalsePositive
     }

     struct Report {
         uint256 id;
         address subject;
         bytes32 transactionHash;
         bytes32 evidenceHash;
         uint8 riskLevel;
         Status status;
         address submittedBy;
         uint256 createdAt;
     }

     mapping(address => bool) public analysts;
     mapping(uint256 => Report) private reports;
     mapping(bytes32 => bool) public transactionReported;

     event AnalystUpdated(address indexed analyst, bool authorized);

     event ReportCreated(
         uint256 indexed reportId,
         address indexed subject,
         bytes32 transactionHash,
         uint8 riskLevel
     );

     event StatusUpdated(
         uint256 indexed reportId,
         Status newStatus,
         address updatedBy
     );

     modifier onlyOwner() {
         require(msg.sender == owner, "Only owner");
         _;
     }

     modifier onlyAnalyst() {
         require(analysts[msg.sender], "Only authorized analyst");
         _;
     }

     constructor() {
         owner = msg.sender;
         analysts[msg.sender] = true;
     }

     function setAnalyst(
         address analyst,
         bool authorized
     ) external onlyOwner {
         require(analyst != address(0), "Invalid address");

         analysts[analyst] = authorized;
         emit AnalystUpdated(analyst, authorized);
     }

     function createReport(
         address subject,
         bytes32 transactionHash,
         bytes32 evidenceHash,
         uint8 riskLevel
     ) external onlyAnalyst returns (uint256) {
         require(subject != address(0), "Invalid subject");
         require(transactionHash != bytes32(0), "Invalid tx hash");
         require(evidenceHash != bytes32(0), "Invalid evidence hash");
         require(
             riskLevel >= 1 && riskLevel <= 5,
             "Risk must be 1-5"
         );
         require(
             !transactionReported[transactionHash],
             "Transaction already reported"
         );

         uint256 reportId = nextReportId++;

         reports[reportId] = Report({
             id: reportId,
             subject: subject,
             transactionHash: transactionHash,
             evidenceHash: evidenceHash,
             riskLevel: riskLevel,
             status: Status.Open,
             submittedBy: msg.sender,
             createdAt: block.timestamp
         });

         transactionReported[transactionHash] = true;

         emit ReportCreated(
             reportId,
             subject,
             transactionHash,
             riskLevel
         );

         return reportId;
     }

     function updateStatus(
         uint256 reportId,
         Status newStatus
     ) external onlyAnalyst {
         require(reportId > 0, "Invalid report ID");
         require(reportId < nextReportId, "Report not found");

         reports[reportId].status = newStatus;

         emit StatusUpdated(reportId, newStatus, msg.sender);
     }

     function getReport(
         uint256 reportId
     ) external view returns (Report memory) {
         require(reportId > 0, "Invalid report ID");
         require(reportId < nextReportId, "Report not found");

         return reports[reportId];
     }
 }
