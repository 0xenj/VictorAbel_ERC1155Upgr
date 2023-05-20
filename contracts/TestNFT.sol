//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";

/// @custom:security-contact enzo.jakobasch@gmail.com
contract TestNFT is
    Initializable,
    UUPSUpgradeable,
    ERC1155Upgradeable,
    OwnableUpgradeable
{
    using StringsUpgradeable for uint256;
    uint256 public tokenId;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __ERC1155_init("");
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function setURI(string memory newUri) public virtual onlyOwner {
        _setURI(newUri);
    }

    function mintBatch(
        uint256[] calldata _ids,
        uint256[] calldata _amounts,
        bytes memory data
    ) public virtual onlyOwner returns (uint256) {
        uint256 length = _ids.length;
        uint256 _tokenId = tokenId;
        for (uint256 i = 0; i < length; ++i) {
            _mintBatch(_msgSender(), _ids[i], _amounts, data);
            ++_tokenId;
        }
        tokenId = _tokenId;
        return tokenId;
    }

    function tokenUri(
        uint256 _tokenId
    ) external view virtual returns (string memory) {
        return
            string(
                abi.encodePacked(
                    uri(),
                    StringsUpgradeable.toString(_tokenId),
                    ".json"
                )
            );
    }
}
