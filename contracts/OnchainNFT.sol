// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract OnchainNFT is ERC721URIStorage {
    using Strings for uint256;
    
    uint256 private _tokenIds;

    mapping(uint256 => uint256) public tokenIdtoLevels;


    constructor() ERC721("Onchain NFT", "OCNFT") {

    }

    function generateCharacter(uint256 _tokenId) public pure returns(string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">'
            '<style>.base { fill: black; font-family: cursive; font-size: 30px; font-weight: 900; }</style>'
            '<rect width="100%" height="100%" fill="#945512" />'
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">I am Blessed</text>'
            '</svg>'
        );

        return string (
            abi.encodePacked(
                "data:image/svg+xlm;base64,",
                Base64.encode(svg)
            )
        );
    }

    function getTokenURI(uint256 _tokenId) public pure returns(string memory) {
        bytes memory dataURI = abi.encodePacked(
            '{'
                '"name": "I am Blessed #",',
                '"description": "I am a Blessed Child",',
                '"image": "', generateCharacter(_tokenId), '"', 
            '}'
        );

        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    function mint() external {
       uint256 newItemId = _tokenIds++;

        _safeMint(msg.sender, newItemId);

        tokenIdtoLevels[newItemId] = 0;

        _setTokenURI(newItemId, getTokenURI(newItemId));
    }
}