// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/PriceResponseMock.sol";

contract DeployResponse is Script {
    function run() external {
        // Start broadcast with private key brought from CLI
        vm.startBroadcast();

        // Deploy contract
        PriceResponseMock response = new PriceResponseMock(2000e8); // initial price example

        console.log("Response contract deployed at:", address(response));

        vm.stopBroadcast();
    }
}
