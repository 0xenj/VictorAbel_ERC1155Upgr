//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ARTbres-et-Forets.sol";

contract ARTbres_ForetsV2 is ARTbres_Forets {
    string private constant VERSION2 = "2";
    uint16 private constant MAX_SUPPLY_ID_V2 = 200;

    function version2() external pure returns (string memory) {
        return VERSION2;
    }

    function mint(bytes memory data) external virtual override onlyOwner {
        require(mintCount < MAX_SUPPLY_ID_V2, "Max supply exceeded");
        _mint(_msgSender(), mintCount, TOTAL_SUPPLY_PER_ID, data);
        ++mintCount;
    }

    function mintBatch(
        uint16 _ids,
        bytes memory data
    ) external virtual override onlyOwner {
        uint256[] memory _idsBatch = new uint256[](_ids);
        uint256[] memory _amountsBatch = new uint256[](_ids);
        uint16 _nextId = mintCount + _ids;
        require(_nextId < MAX_SUPPLY_ID_V2, "Max supply exceeded");
        for (uint16 i = 0; i < _ids; ++i) {
            _idsBatch[i] = mintCount + i;
        }
        for (uint16 i = 0; i < _ids; ++i) {
            _amountsBatch[i] = 10;
        }
        _mintBatch(_msgSender(), _idsBatch, _amountsBatch, data);
        mintCount = _nextId;
    }
}
