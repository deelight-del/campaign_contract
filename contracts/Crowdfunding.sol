//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
* @notice smart contract for crowd funding.
* @author deelight-del.
*
*/

contract CrowdFunding {
  /// constructor function
  string title;
  string description;
  address benefactor;
  uint goal;
  uint amountRaised;
  uint deadline;
  constructor(string memory _title, string memory _desc, address _benefactor, uint _goal, uint _duration) {
    title = _title;
    description = _desc;
    benefactor = _benefactor;
    goal = _goal;
    deadline = block.timestamp + _duration;
  }
}
