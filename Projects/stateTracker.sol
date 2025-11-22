// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OrderTrack{
    enum Status{Pending, Shipped, Delivered}
    Status public currentStatus;

  // set to Pending automatically when contract is deployed
    constructor() {
        currentStatus = Status.Pending;
    }

    // move from Pending → Shipped
    function shipOrder() public {
        require(currentStatus == Status.Pending, "Order Already Shipped or Delivered");
        currentStatus = Status.Shipped;
    }

    // move from Shipped → Delivered
    function deliverOrder() public {
        require(currentStatus == Status.Shipped, "Order not Shipped yet");
        currentStatus = Status.Delivered;

    }
    // view current Status
    function getStatus() public view returns(string memory){
        if(currentStatus == Status.Pending) return "Order Pending";
        if(currentStatus == Status.Shipped)return "Order Shipped";
        return "Order Delivered";
    
    }
}