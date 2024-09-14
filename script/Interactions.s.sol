// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        //passing the address of the most recently deployed contract into fundme() to call the fund function and pass in a value
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    //run is used to retrieve the CA of the most recently deployed contract
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    uint256 SEND_VALUE = 0.1 ether;

    function withdrawFundMe(address mostRecentlyDeployed) public {
        //passing the address of the most recently deployed contract into fundme() to call the withdraw function and pass in a value
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    //run is used to retrieve the CA of the most recently deployed contract
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(mostRecentlyDeployed);
    }
}
