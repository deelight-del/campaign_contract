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
  uint id;
  constructor(uint _id, string memory _title, string memory _desc, address _benefactor, uint _goal, uint _duration) {
    title = _title;
    description = _desc;
    benefactor = _benefactor;
    goal = _goal;
    id = _id;
    deadline = block.timestamp + _duration;
  }

  ///@notice dontate to a given campaign.
  function donateToCampaign() {
    ;
  }
}

//TODO: create a factory that will create a new CrowdFunding contract ad save it.
//And also retrieve a given contract based on its id, using mapping.
