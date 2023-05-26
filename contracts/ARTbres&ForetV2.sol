//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ARTbres&Foret.sol";

/// @custom:security-contact enzo.jakobasch@gmail.com
contract TestNFTV2 is TestNFT {
    function mintBatch(
        uint256[] calldata _ids,
        uint256[] calldata _amounts,
        bytes memory data
    ) public virtual override onlyOwner {
        _mintBatch(_msgSender(), _ids, _amounts, data);
        tokenId += _ids.length;
    }

    function mint(
        uint256 _ids,
        uint256 _amounts,
        bytes memory data
    ) public virtual onlyOwner {
        _mint(_msgSender(), _ids, _amounts, data);
        ++tokenId;
    }

    function tokenUri(
        uint256 _tokenId
    ) external view virtual override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    _baseURI,
                    "/",
                    StringsUpgradeable.toString(_tokenId),
                    ".json"
                )
            );
    }
}
