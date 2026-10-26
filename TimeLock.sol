// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

contract TimeLock {
    uint public unlockTime;
    address public owner; //only this account can withdraw 

    constructor(uint _unlockOffset) payable { 
        unlockTime = block.timestamp + _unlockOffset;
        owner = msg.sender;  //represent the address that deploy this contract
    }  
      

    function getTimeRemaining() external view returns (
            uint daysRemaining,
            uint hoursRemaining,
            uint minutesRemaining,
            uint secondsRemaining
        )
    {
        if (block.timestamp >= unlockTime) {
            return (0, 0, 0, 0);
        }

        uint remaining = unlockTime - block.timestamp;

        daysRemaining = remaining / 86400;
        hoursRemaining = (remaining % 86400) / 3600;
        minutesRemaining = (remaining % 3600) / 60;
        secondsRemaining = remaining % 60;
    } 
    function withdraw() external {
        require(block.timestamp >= unlockTime,"You can't withdraw yet");
        require(msg.sender == owner, "only owner can withdraw");
        (bool sent, ) = payable(owner).call{value: address(this).balance}("");
        require(sent == true, "Failed to send");
        //address(this).balance: the balance of the contract
        //owner.call{value: address(this).balance}(""): send the balance to the owner
        //"" is the data that we want to send to the owner
        //we use call instead of transfer to send the balance to the owner because we want to send the balance to the owner even if the owner is a contract
    }  
}
