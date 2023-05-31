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
________________________________________________________________________________

'||'  '|'  ||            .                          |     '||              '||  
 '|.  .'  ...    ....  .||.    ...   ... ..        |||     || ...    ....   ||  
  ||  |    ||  .|   ''  ||   .|  '|.  ||' ''      |  ||    ||'  || .|...||  ||  
   |||     ||  ||       ||   ||   ||  ||         .''''|.   ||    | ||       ||  
    |     .||.  '|...'  '|.'  '|..|' .||.       .|.  .||.  '|...'   '|...' .||. 
                                                                                     
_________________ _______________ _____ _______________ ____ __ _____________  _

_________________ __________ _____ __ _ __ __ _ ___ __  _________ __ _ __ _____

___________ ______ _________ __ ___________ ,____ _____ _ _ ___ _______ __ _  __

____________________________________▄__ _ _╢╢r_______________ __ __  _  _ _ ____

___ ______________________ _________██ ╥_ ╣Ñ`▄▄___________  _ __   _ _ ____ __

__ _________ _________ ____╦╖_╓╫__,@_▄▓▓_▓▄▐▀▀▌╫________ _ ___  __ ____  _  _ _

__________ __ __________ ╖ ▄"╘▐╙╔,▓▓▓▓▌▓▌▀█▀╢▄▀▌╟╬╩^ __ _ ____  ___   ____ ___ _

________________________ ▒╫▀▓▌▓▓▌▓╓@▓'███▀▀▓▀▓▌▀▀*▓N╓▓▓___ __  _   ____  ___ __

_______________________"▓▓▓_╗▓`_██▓▀ ▄█▒╫`▓█╔'╓_▓▌▄▀▄▓▄ __ ___ _  __ ___ __    _

__________ _______ _▄▄j╥,,,█▓▓▓▓▓▌▓▓█▌φ ▄▄▌▓@▌▒╛╓▌@[▄]▓▓╜_ __   _ _  __ ____ _ _

________ __ _____φ╗_▀▀_╚╝_▀▀▀█▌_╖▀███╙▓▀▓█▀▌▓▌g▄█▄▓▓¿▓ ▄▄__,_____  _ _  ____ _ _

_____________╓,___"▌╘▓N╙▓▓N▄▓▓▀▄▒▒U▐▓▄▓▄m@_█▀║█▀▒▒╜▓█▌╢▓,∞_▓▌__ _  ___ __ _ ____

_____________╘▓▓_▓▄╓▓▓▄ ╖,¥▓▓▀▀██_▓Q▓_`▓Γ╙▓█▀▓▓_▓,▄▓▒@,▐▓▌²_║╢╫ _ _  __  __ ___

______________,▄█▓▄,▓▓▀█╙▒╜ _sm▄█▌▓╝▐█╚███`╔Ç▐▀ ╙▓█Æ▌Æ▓▄▀╣╢▄Å╙▓▓▓▄_  ___ __ __

_ _____________._╔▓▓.▓██▀██▀▀██▓█▌_▓▄███▀╔[▀▓█║▒Ü█]▒▓▄▓█▓▀▐▓▓A ._░_ __     __ _

_________________`╓╥╓▐▓▀,╔▀▀▀╓@▓▀███▓███╙▄▌████▀▀██▀▒H╖`▐▓r __ __  _  __ __ _ _

__________________Ñ╩╙▀▀#▓▓▄A&▓█▀▀▓▓▀██████▓▄_╣╣╦▀▓▌▀▀▓▓▄▓▌╓╢╢b___ ___  ____░░_░

__________________ ___╓╗µ╒▓█_ _ ▓▀"_▐███▌_╙▀╩_ ___ _╝╢ ▀█▓____ _  _ ____   _ __░

__ __________________╚╩╙__ __________██▓▌ _ __ __ ___ _   _   __ _ __ __ _ ____

______________ ________________ _____█▓▓▌__ ____ ___ _   _ __ _ ░ _ _ _ __░  _ ░

_________ ___________________________███▌___  ___  ____ _  _ _    _   _____ ░_░

_______ ___________________________ _██▓▌__  ________  __   ____ ░ _░_   _░_ _ ░

____ __________________ __ __________███▌__  ____ ___ __  _      _░__ __  ░   __

_____________________________________████_ _____ ___________ _░ _ _ __░__░__░__

____________________________ _______▐█▓██▄________ ___ ________ _ _  _░░ __░░  '

__________ _______________________∞▓██▀██▀▀═ __ __ _ _ _ __ _ ___    __     _  ░

_____________________________ __ ________________ ___ _ _ _ ___░ _ ░ ░░___ ░░ ░░

_______________________________________ ________ __ _ _ __ __  _ ░░_____ _ ░░░░░

__________________ ____ ____________ _______________ _  _    _  _  ░░___ ░░░░░░░

___________  ________ __ __ ___ ___ _______________  __ __ _ __ _      ░ _░_░░░░

_______________________________________ ___________ ___ _ _ __ __ __░░____░░░░░░
*/

/// @custom:security-contact enzo@nftheorem.com
contract ARTbres_ForetsV3 is
    Initializable,
    UUPSUpgradeable,
    ERC1155Upgradeable,
    OwnableUpgradeable
{
    using StringsUpgradeable for uint256;
    uint16 private mintCount;
    uint16 private constant TOTAL_SUPPLY_PER_ID = 10;
    uint16 private constant MAX_TOTAL_SUPPLY = 10000;
    uint16 private constant MAX_TOTAL_SUPPLY_V1 = 1000;
    uint16 private constant MAX_SUPPLY_ID = 1000;
    uint16 private constant MAX_SUPPLY_ID_V1 = 100;
    string private _baseURI;
    string private _contractURI;
    string private constant NAME = "Artbres & Forets Collection";
    string private constant SYMBOL = "ARTBRES&FORETS";
    string private constant VERSION = "1";
    uint16 private constant MAX_SUPPLY_ID_V2 = 200;
    uint16 private constant MAX_TOTAL_SUPPLY_V2 = 2000;
    string private constant VERSION2 = "2";
    string private constant VERSION3 = "3";
    uint16 private constant MAX_SUPPLY_ID_V3 = 300;
    uint16 private constant MAX_TOTAL_SUPPLY_V3 = 3000;

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
        return _tokenId < mintCount;
    }

    /**
     * @dev Return the contract's version
     */
    function version() external pure returns (string memory) {
        return VERSION3;
    }

    /**
     * @dev Return the collection's name
     */
    function name() external pure returns (string memory) {
        return NAME;
    }

    /**
     * @dev Return the collection's symbol
     */
    function symbol() external pure returns (string memory) {
        return SYMBOL;
    }

    /**
     * @dev Return the total maximum supply of the collection
     */
    function maxTotalSupply() public pure returns (uint16) {
        return MAX_TOTAL_SUPPLY;
    }

    /**
     * @dev Return the total maximum supply of collection's first version
     */
    function maxTotalSupplyV1() public pure returns (uint16) {
        return MAX_TOTAL_SUPPLY_V3;
    }

    /**
     * @dev Return the maximum supply of ID in Version 1
     */
    function maxSupplyId_V1() public pure returns (uint16) {
        return MAX_SUPPLY_ID_V3;
    }

    /**
     * @dev Return the maximum supply of collection's ID
     */
    function maxSupplyId() public pure returns (uint16) {
        return MAX_SUPPLY_ID;
    }

    /**
     * @dev Return the total supply
     */
    function totalSupply() public view returns (uint16) {
        return (mintCount * TOTAL_SUPPLY_PER_ID);
    }

    /**
     * @dev Return the total tokenId supply
     */
    function totalSupplyId() external view returns (uint16) {
        return mintCount;
    }

    /**
     * @dev Return the supply per tokenId
     */
    function totalSupplyPerId() public pure returns (uint16) {
        return TOTAL_SUPPLY_PER_ID;
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
     * @param newURI - IPFS pointing to the new base URI file
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
    function uri(
        uint256 _tokenId
    ) public view virtual override returns (string memory) {
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
     * @dev Main mint - external function
     * @param data - data
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint the token
     */
    function mint(bytes memory data) external onlyOwner {
        require(mintCount < MAX_SUPPLY_ID_V3, "Max supply exceeded");
        _mint(_msgSender(), mintCount, TOTAL_SUPPLY_PER_ID, data);
        ++mintCount;
    }

    /**
     * @dev Main mintBatch - external function
     * @param _ids - number of tokenId to mint
     * @param data - data
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint tokens
     */
    function mintBatch(uint16 _ids, bytes memory data) external onlyOwner {
        uint256[] memory _idsBatch = new uint256[](_ids);
        uint256[] memory _amountsBatch = new uint256[](_ids);
        uint16 _nextId = mintCount + _ids;
        require(_nextId < MAX_SUPPLY_ID_V3, "Max supply exceeded");
        for (uint16 i = 0; i < _ids; ++i) {
            _idsBatch[i] = mintCount + i;
        }
        for (uint16 i = 0; i < _ids; ++i) {
            _amountsBatch[i] = 10;
        }
        _mintBatch(_msgSender(), _idsBatch, _amountsBatch, data);
        mintCount = _nextId;
    }

    /**
     * @dev Allow owner to withdraw any ether sent to this contract
     *  - Verify that the caller is the owner
     */
    function withdrawEther() external virtual onlyOwner returns (bool success) {
        (success, ) = payable(_msgSender()).call{value: address(this).balance}(
            ""
        );
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[47] private __gap;
}
