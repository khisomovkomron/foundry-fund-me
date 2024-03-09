// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script{
    uint256 constant SEND_VALUE = 0.01 ether;

    function fund_FundMe(address mostRecentlyDeployer) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployer)).fund{value:SEND_VALUE}();
        vm.stopBroadcast();

        console.log("Funded FundMe with %s", SEND_VALUE);

    }

    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);

        vm.startBroadcast();
        fund_FundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

    }

}


contract WithdrawFundMe is Script{
    function withdraw_FundMe(address mostRecentlyDeployer) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployer)).withdraw();
        vm.stopBroadcast();


    }

    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        
        vm.startBroadcast();
        withdraw_FundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

    }
}