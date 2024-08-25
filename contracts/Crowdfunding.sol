//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
* @notice smart contract for crowd funding.
* @author deelight-del.
*
*/

contract CrowdFunding {
  /// constructor function
  
  struct Campaign{
    string title;
    string description;
    address benefactor;
    uint goal;
    uint amountRaised;
    uint deadline;
    uint id;
    bool claimed;
  }
  uint private countId = 1;

  // Map id to campaigns.
  mapping(uint => Campaign) private campaignMapping;

  // Campaign array for storing all campaigns
  //Campaign[] private campaigns;

  event donateEvent(address sender, uint amount);
  event createCampaignEvent(uint _id);
  event endCampaignEvent(bytes _data);

  function createCampaign (string memory _title, string memory _desc, address _benefactor, uint _goal, uint _duration) public {
    Campaign memory newCampaign = Campaign({
      title: _title,
      description: _desc,
      benefactor: _benefactor,
      goal: _goal,
      deadline: block.timestamp + _duration,
      amountRaised: 0,
      id: countId,
      claimed: false
    });
    //campaigns.push(newCampaign);
    campaignMapping[countId] = newCampaign;
    // Increase count for next contract.
    emit createCampaignEvent(countId);
    countId++;
  }


  ///@notice dontate to a given campaign.
  function donateToCampaign(uint _campaignId) public payable {
    // ensure that the campaign_id exists.
    require(campaignMapping[_campaignId].id > 0, "Campaign ID does not exist");
    require(block.timestamp < campaignMapping[_campaignId].deadline, "The time for this contract is passed.\nNo longer accepting donations");
    require(campaignMapping[_campaignId].claimed == false, "This campaign has been ended already.");
    require(msg.value > 0, "Invalid amount.\n Specify something above 0");
    campaignMapping[_campaignId].amountRaised += msg.value;
    emit donateEvent(msg.sender, msg.value);
  }

  // Define receive function.
  //receive () payable external {
  //  emit donateEvent(msg.sender, msg.value);
  //}

  ///@notice transfer funds to benefactor.
  function endContract(uint _campaignId) public payable {
    // ensure that the campaign_id exists.
    require(campaignMapping[_campaignId].id > 0, "Campaign ID does not exist.");
    require(block.timestamp >= campaignMapping[_campaignId].deadline, "The contract has not yet reached the specified end date.");
    require(campaignMapping[_campaignId].claimed == false, "This campaign has been claimed already.");
    (bool sent, bytes memory data) = (
      payable(campaignMapping[_campaignId].benefactor)
    ).call{value: uint128(campaignMapping[_campaignId].amountRaised)}("");
    require(sent, "Transfer of Funds to benefactor, Unsunccessful. Try again.");
    if (sent == true) { campaignMapping[_campaignId].claimed = true; }
    emit endCampaignEvent(data);
  }
}

//TODO: create a factory that will create a new CrowdFunding contract ad save it.
//And also retrieve a given contract based on its id, using mapping.
