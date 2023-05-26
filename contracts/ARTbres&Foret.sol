//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/// @title: ARTbres&Foret
/// @author: nftheorem.com

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";

/*
╣╢╬╬╫▓▓▓▓▓▓▓╬▓▓▓▓▓╣╣╣▓▓▓▓╬▓▓▓╬▓▓╫▓▓▓╣▌█▀█▒▓█▓▓▀█▓▓▒╓██▌▄▓▓▓▓▓▄▓▓▓▓▓▓▓▓▓▓▓▓@▒▒╫▓▓

╬▒▓▓▓╬▒▒▒╢▓▓▓▓▓▓▓▓╢▒▓▓╟▀▓█▓▓██▌▓▓▐Ñ▓▒▀█▓▓Ü▓█▌▐█▓▓▀▓▓▓██▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓╣

▓▓▓███▓▓▓▓▓╠╣▓▓▓▒▒╫▓▓╣▓█▓▓█▓██▌▓▓▓▐▀▒▐██▒_▓▓▓▓▐▓@▓▓▓▐██▒▓▓▓▓▓▓██▓▐▓▓▓▓▓▓▓╬╢▒░░╙▀

▒▒▓▓▓▓▒▒▒▒░╣▓▓╬░░▐▓▓▓╣y▓██▓▓▓▌║▓▓░╫▓▓▐██▒▒▒▒▒▓▓▓▓▐▓▓▒██╬▓▓▓▓▓╢▓▓▌▓▓▓█▓Ñ╣╬▓▓▒▒▓Ñ░

▒▓█▓▓▒▒▒▄▓▓▓╩░░g▓▓╬¥▓▓▓▓████▓▐▄█║╣▒▓█▐██▓╬:▓▓╫╬▀▓▒,_▓██╬▓╣▓▓▓╣╬▄▌▒▓▓▌▓▓▄Ñ▓▓▓╣▓▓╣

██▓▓▒▒▓▓▓▓▓▒░╥▓▓▓▒▓▓▓▓▓▓▓▓▀▌██▓ñ▓▌▐@▌▓███▓▄8▓▓▓▓@▄Ñ▒███▒▓█▓▓▓▐@▒▓▓▄▄▀▒░░░╢▓▓▓▓▓▓

█▓▓▒╫▓▓▓▓▒░░▓▓▓▓▒╣╟▀▓█▓▓▓▓▓▓▓▓▓▓▓▓█╣╬╫███▌▒▒m▓╣Ñ▓▌╣████╨▒▓▓▓▓╣╜▓▓▓█▓▀▀▓NÑ▓▓▓╣▓▓▓

▓╬▒╫▓▓▓▓╣░,▓▓▓▓Ñ▐▄▓▀▓▓█▓▓╣▓█▌▓▓█▓█▐▄▐▒▐████▄╣▄▒▒╝░████▒╣╫▓▒▐▀▓Φ▓▓▓▓▌▓▐▒▓▓▌╫▓▓▓▓▓

▌╣▒▓▓▓▓▓▓▒╣▓▓▓▓░]▓▓║▓█▀▓╠▄▐╣╣▓╫▓▐█▓▓▓T▒▓▒█████▄▒▒███▀▓█╣▒╢▓╫▓▓╢▓▓▓▓▓▓▓▓▄]╣╫▓▓▓▓▓

▓╢▒╠▓▓╬▓▓▓▓▓▓▓▓▒▓█▓╠▓█▓▓Ñ▌▀▓▓▓▓▓▄▐▓▓▀▒]╣▌▓╣▀███████▐▓█▌▌▓▓Ñ▓╢▄▓║█▌▓▓▀▓▓█╣[▓▓╬Ñ░░

▓▒▒░▒▓╣▓▓▓▓▓▓▓▓▒█▓▌▄░▄▓▓▓▓[█▓▐█▓█▓╣█▓╥φ▀▓▀▓▓╣▓████▒▀▓▓╬▓▌▓▓▓▓▓▓▓▓█▒▓▓▓▓▓╫╓▓╣▒▒░_

▌▒▒`  ░▒▓▓▒▒░▓▓▓╢▌▓█▒Ü█▌▓▓τ█▓▓▓▓▓██▓▄▓▓▐█▐▌▌▓▌░███▒▓╬╫▄▓▀╢▀╬▀▓╣▓▓▓░▌▀▀▓▓▓╢▓╣╣▓▓▒

▒▒░___ ░▓▓▓▒░░╫▓╣║Å╣▓▓▓▓▓▌▄█▓▓▓▓██▌▒▓▓█▌█▓▌█▌j▒▐██▒▒▒▓▓║░▀▒▌▄▄,▒╢▒▓▓▓▓▐▀╟╢▓▓╢╢▓▓

░░░ _   ▒▓▓▓@▒▒╫▓╣▐▓▀▓▓███▓▓▌█▓▓▓▌▓▓▓▓██▀▓▌█▓█▒ü██╬µ╢▓▓▓▓╫▌▒▒▓╬▓▓▓▓▓▌█▌▓╣╫▓╣▒░░░

▒▒░░_ _ ░▒▓▓▓╣▒▒░▓▓▓▓▓▌╘▓▓▓░█▓█▀▓▓████▓█▓▌▌██▓▌B██▒▀╙█▄@▓▓▓╬▓╢▓║▀▓┐_▓╬╣▒▓▓Ñ░░_░_

▓▒▒░  __░░║▓▓█▓╣░░▒▓▓▄▀█▓▓█▓▓▓██▓███▓▓▓█▓██▓▓█▌╠██▓▓▓▓▓█▓Ñ╢▓@║╢`▐▓▓▒▐{▄▓▓╝░ _ _░

▓▓▄▒__ ░▒╢▒▓▓▓▓▓╣▒░░▒▒╫▓▓▓▓▓██▌▓▓╢▓▀B▓█▌▓▓▓▓▓▓▓███╜╝¿▓█▓▌Å▒▓╢╖┌╢@▓╠╟╣æ▓▓▒__░░░░∩

▐▓▓▄µ╖▒▒▒▓▓▒░▄▓▓▓╣▒▒▒▒▄▓▓▓▄▒▒▒▒╬▓▓▒▓▓█▓██████▓▓██▌░╙]▓▓▓]m$█▌.j▓Ü╬▓▓▓▓▒▒▒▒▒▒▒▒▒▓

░░║▓▓▓▓▓▓▓▓▓╢▓╢╬▓▓▓▓▓▓▓▓╢╜╫▓▓▓╬▒▒▒▒╢▀▓██▌███▓▓███▒▄╫╠∩▌░║░▒▒▓▒║╢▓▓▓▓▓▓▓▓▓▓▓▓▓╬▒▒

▒▄▄▄▄▄▄█▄▄██▄▄▄▄▄▓▓██▓▓██████████████████▓██████░g█▌█▌B▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄▄▄▄▄▄▄▓▓██

█████████████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▓▀▀▀▓▓▓▌▒▒▒██████████▓██▓█████▓█████████████████████▀

███████████████████▓▄▄▄▄▄▄▒▒▒▒▒╜▒▒▒▒▒▒█████████████████████▓▓Ñ╢╣▒▒▒▒▒▀▀▀▀▀▒▒▄█▌▒

███▄▄▄▄▄██▄▄▄▒▀▀▀▀▀██████████████████████▓▓▀███╢╢▒▒▓█████▓▓▓▓▓▓█████████████████

▀▀▀▀▀▀▀▀▀███████████████▄▄▄▒▒╣▒▒▒╙▒▒▒▀███▌▓▄███▒▒████████▀▀▀▀▀▀▀▀▒░▒▒▒▒▄▄▄▄▄▓╣▒▄

▒▒▒░░░░░░'`░▒▒▒▒▒░░░░▒▀▀▀▀▀█████▄▄▄▄▄▄█████▓████████▀⌠,▄▄███████████████████████

███▄▄▒░.,___░░░░░░`░░```_░░░▒▒▒▒▀▀▀▀▀▀███▓█▓███▀█g▄▄██▀▀__ ░░▒░░▄▄███████▀▀▒▒▒▒▒

██████████████▄▄▄▄▄▄▄╓,,▄▄,,░░░░░`__ _╙████▓███____  _░▒░░▄▄████▀▀▀▀▀▀▓▒▒▐▄▄▄▒▄▄

███████████████████████▀▀▀▀███████████▄████████▒╖¬⌐,g▄▄████▀▀`_░░░░▒▒▒▒▒▒║▒▒▀▀██

████████▀▀▒▒▀▒▒▒▒▒░░▒▒▒╓▒╖╖╣▓╩╙╢╫▓█▌╫▒▒█████████████▀▀`░░░░_░╖░░__░░▒▒▒▒╜▒▒╢╣%╫▓

╢▒║▒▒║╣╣╣╣▒▒▒▒░░▒▒▒░▒▒░╠▄▓╜" µ▓█████▌╓███▌╠▓▓███Ñ__ __ ░ _░_░░░.░▒. ░_▒▒▒▒▒╨▒▒▒▒

▒▒▒▒▒▒▒▒▒╫▒░░   µ▄▄▄▓▓▓╢▒▄▄██▓╩╙╣╫▓▄████▌_]▓▀▓████▄____░ _ ░░░░░.`__░░▒▒▒▒▒▒▒▒▒▒

╣▒▒║╢╣╣╣▄▄▄▄██████▓█▓███▀▀▒▒░▄▄████████▓▓╔__j▓█▀▀▀█████▓█▓▓█▓▓▓▓▓▓@▄▄▄▄▄▄▄▒▒▒▒▒▒

╣╬▓███████▀▀▒▒▒▀▀▓Ñ▒▓▄▄▄▄████████▀█▓▒╫▓▀░░█k▐▓█ `▒░▓▓▓▓▓▓▓╣_`╟▓▓▓▓▓▓▓╫╣▓▓█▓▓▓▓▓█

█▄████▓▓▒▒▒▒▒▄▄▄████████████▓▒µ╓┐╟▓▓▓██▄▓▓█▓███r▒▀▄▒▒▐█████▓███▓▓L__▐▓▓▓▓▀█▓▓▓██

████▓▓╣▒▄▄▄███████▀█▓▓█▓█▌▓▓▓▓▓▓███▓▓██▓▀Ñ▓▒║▐██▄▒╣▌▓╫@▄▓▓▓▓▓╢╣╣▒▀██▓▓▓▓▓▓▓▓▓▓▓█

██▓╣▒▄██████▀██▓▓▓▓████▓██▓▓▓▓▓███▀▀▒▒▒╬▓█▀▐▓▌_╚█▓▓▓▓║███████▓▓@`]▓▓l║╫▓▓▓▓▓▓▓▓▓
*/

/// @custom:security-contact enzo.jakobasch@gmail.com
contract ARTbres_Forets is
    Initializable,
    UUPSUpgradeable,
    ERC1155Upgradeable,
    OwnableUpgradeable
{
    using StringsUpgradeable for uint256;
    uint256 public tokenId;
    string private _baseURI;
    string private _contractURI;

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

    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens start existing when they are minted (`_mint`),
     * and stop existing when they are burned (`_burn`).
     */
    function _exists(uint256 _tokenId) internal view virtual returns (bool) {
        return _ownerOf(_tokenId) != address(0);
    }

    /**
     * @dev Allow to set contract URI
     * @param newContractURI - IPFS pointing to the new contract URI file
     *  - Verify that the caller is the owner
     */
    function setContractURI(
        string calldata newContractURI
    ) external virtual onlyOwner {
        _contractURI = newContractURI;
    }

    /**
     * @dev Return contractURI
     */
    function contractURI() external view virtual returns (string memory) {
        return _contractURI;
    }

    /**
     * @dev Allow to set base URI
     * @param newBaseURI - IPFS pointing to the new base URI file
     *  - Verify that the caller is the owner
     */
    function setBaseURI(string calldata newURI) external virtual onlyOwner {
        _baseURI = newURI;
    }

    /**
     * @dev Return baseURI
     */
    function baseURI() public virtual returns (string memory) {
        return _baseURI;
    }

    /**
     * @dev Return URI's extension
     */
    function _extensionURI() internal view virtual returns (string memory) {
        return ".json";
    }

    /**
     * @dev Return tokenURI
     */
    function tokenUri(
        uint256 _tokenId
    ) external view virtual returns (string memory) {
        require(_exists(_tokenId), "URI query for nonexistent token");

        return
            string(
                abi.encodePacked(
                    _baseURI,
                    StringsUpgradeable.toString(_tokenId),
                    _extensionURI()
                )
            );
    }

    /**
     * @dev Main mintBatch - external function
     * @param _ids - number of tokens to mint
     * @param _amounts - number of tokens to mint
     * @param data - number of tokens to mint
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint the token
     */
    function mintBatch(
        uint256[] calldata _ids,
        uint256[] calldata _amounts,
        bytes memory data
    ) external virtual onlyOwner {
        tokenId += _ids.length;
        _mintBatch(_msgSender(), _ids, _amounts, data);
    }

    /**
     * @dev Main mint - external function
     * @param quantity - number of tokens to mint
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint the token
     */
    function mint(
        uint256 calldata _ids,
        uint256 calldata _amounts,
        bytes memory data
    ) external virtual onlyOwner {
        ++tokenId;
        _mint(_msgSender(), _ids, _amounts, data);
    }
}
