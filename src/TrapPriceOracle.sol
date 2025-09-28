// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

interface IPriceFeed {
    function latestAnswer() external view returns (int256);
}

contract TrapPriceOracle is ITrap {
    // Semua konfigurasi langsung hardcoded
    address public constant RESPONSE_CONTRACT = 0x61f71401bDbE8c83A7a847cE345d156f4134D7a6;
    int256 public constant THRESHOLD = 2000e8; // example of 2000 threshold
    bool public constant TRIGGER_ABOVE = true;

    function collect() external view returns (bytes memory) {
        int256 price = 0;
        (bool ok, bytes memory ret) = RESPONSE_CONTRACT.staticcall(
            abi.encodeWithSelector(IPriceFeed.latestAnswer.selector)
        );
        if (ok && ret.length >= 32) {
            price = abi.decode(ret, (int256));
        }

        return abi.encode(price, THRESHOLD, TRIGGER_ABOVE);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        require(data.length > 0, "missing data");
        (int256 price, int256 thr, bool above) = abi.decode(data[0], (int256, int256, bool));

        if (above) {
            if (price > thr) {
                return (true, abi.encode("Price above threshold - triggered"));
            }
            return (false, bytes(""));
        } else {
            if (price < thr) {
                return (true, abi.encode("Price below threshold - triggered"));
            }
            return (false, bytes(""));
        }
    }

    function oracleRespond(string calldata decision) external pure returns (string memory) {
        return string(abi.encodePacked("TrapPriceOracle response: ", decision));
    }
}
