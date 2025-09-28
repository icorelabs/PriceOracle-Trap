// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PriceResponseMock {
    int256 private price;

    constructor(int256 _initialPrice) {
        price = _initialPrice;
    }

    function setPrice(int256 _price) external {
        price = _price;
    }

    function latestAnswer() external view returns (int256) {
        return price;
    }

    function oracleRespond(string calldata decision) external pure returns (string memory) {
        return string(abi.encodePacked("PriceResponseMock ack: ", decision));
    }
}
