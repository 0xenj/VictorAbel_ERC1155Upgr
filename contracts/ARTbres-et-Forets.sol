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
                                                                                     
________________________________________________________________________________

_________________________.,_____________________________________________________

______________________ ╓M╣╥U_ _______________________ ╗_@╩^_____________________

_______________,____╒▄▓▓▓▓╬ÿ\║▒╖_____________________~═║╫╣@t____________________

_____________┐╓╦─¿▒=╩▓██▓╣▄"╜╬`_____________________▓▌▓▓╬╫@▒┴`__________________

___________▄▓@▓╬@▒v──_"╩" C_._ '_`________________╥m▄╣▓▓╣╬║m▒╖`_________________

____________▓██▓▌▓Ñ╖__Ç_,.╤╣╖╣╢╣┐[  ______________╩╦▓▓▄▓╢╢╢╣Ü▒╣ß─_______________

_______., _.__`╙╛▒╣╖╖▒▒║▓Q▓▌╬Å` __________________╗@▓▓▓▀╫╢╠▒@@Ñ▒\╗______________

______ⁿ&╥)` "Ñ▓█▓▓▓╫▒╦▒║Ñ▀Ñ▓_ ___________________.▓▓▄▓▓▄▓▓╣▓Ñ╣╫╣@º______________

______"█▓╫╢╫╬]╫▓▓▓▓╣▓╣▓╢▓▓╣ç╕*_╥╒_____________╒▓▓██▓▓▓█▓▓╢╣╢╣╬╫╬╢▒______________

______╚▓▀▓▓╣▓ÿ▒║∩╣╫╛╬╚═███▓▌▓Ñ▄▓_ ____________╘█▓▀▓▓▓▓╬╣╣╠╣Ñ╢╣╫Ö╨_______________

_________∞▄▓╫╣▓╬╣▄▓=═; _▓▐▀▓▌ ""________________▓▓█▓▓▓▓█▓█╫╜▓▄╢▒________________

__________▓▓▓Ñ▓▓██_╙..╟▓▓╣Ñ@╖▒M─_ _______________`▓`"╙╙▓▓▓╦_ _  ________________

_____________"_ _ ___╖`█▓▓▓█▓▓▓$`_ _____________________][______________________

_____________________]╔`_"` _^ _________________________][______________________

_____________________║`_________________________________⌠▌______________________

______________________╗_________________________________╟▌______________________

______________________▒______________________________╖╥m▓▀m╖╖.__________________

_________________──HH╣╨HHH─________________________________ ____________________

________________________________________________________________________________

________________________________________________________________________________

_______________ _-_________╓_"╓______________________ _ _¿_╓_─░ ] w_____________

_____________╓╓_]░╨_ ____∩▒▒X%╫═______________,╓M_╞^M╚"g@[╟@╓Φ@²m╜.  ___________

______________ ▓▓╫▒#_÷▓▓▓▓▓▓▓╕` ___________┌_@╜╖ë╝╩┐╝▓▐╬╫╢▓▒╢%▒╣Ü▒.╠└/`_________

_______________`▓█▓▄╨_║▀▀▀`_______________╓╓║╫╔Ñ▓▓▓▓▓██▓▓▓▓██▓▓▓▓▓▓▓▓┌,_________

____________▓▓▒_▐██▓▓╜▒─τ╦~~_____________╪╫▄╫▓▓▓▓███████▓█▌███▓████▓▌▓φ,________

_____________╙▀╬▒╢___╙─ß╗n@╖"-___________ ▓▓█████▀█▀██═.╖" _╣▐▓ ╥¿ _▀▀▀▀`_______

____________═mΦ▄║|▒╥▓╓██▓▓▄▒▒@▒__________╤▓████^~╟"╚___.@^__▓██▓▓╫@╥╓___________

_____________'▀▀▀▀█╧]`_╘▀▀╨ __ ___________ '""____ _`-__▌_,∞╩__▀"▀▀▀▓▄__________

____________________]__________________________________`▓__________ ____________

____________________]▌__________________________________▓_______________________

_______________ _╓╖╥@▓m╥╖~__________________________``"^^^"``___________________

________________________ _______________________________________________________
*/

/// @custom:security-contact enzo@nftheorem.com
contract ARTbres_Forets is
    Initializable,
    UUPSUpgradeable,
    ERC1155Upgradeable,
    OwnableUpgradeable
{
    using StringsUpgradeable for uint256;
    uint8 private constant VERSION = 1;
    uint16 public _totalSupplyId;
    uint16 private constant TOTAL_SUPPLY_PER_ID = 10;
    uint16 private constant MAX_TOTAL_SUPPLY = 10000;
    uint16 private constant MAX_TOTAL_SUPPLY_V1 = 1000;
    uint16 private constant MAX_SUPPLY_ID = 1000;
    uint16 private constant MAX_SUPPLY_ID_V1 = 100;
    string private _baseURI;
    string private _contractURI;
    string private constant NAME = "Artbres & Forets Collection";
    string private constant SYMBOL = "ARTBRES&FORETS";

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
        return _tokenId <= _totalSupplyId;
    }

    /**
     * @dev Return the contract's version
     */
    function version() external pure returns (uint8) {
        return VERSION;
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
        return MAX_TOTAL_SUPPLY_V1;
    }

    /**
     * @dev Return the maximum supply of ID in Version 1
     */
    function maxSupplyId_V1() public pure returns (uint16) {
        return MAX_SUPPLY_ID_V1;
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
        return (_totalSupplyId * TOTAL_SUPPLY_PER_ID);
    }

    /**
     * @dev Return the total tokenId supply
     */
    function totalSupplyId() public view returns (uint16) {
        return _totalSupplyId;
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
     * @dev Disable uri() function
     */
    function uri(
        uint256 tokenId
    ) public view virtual override returns (string memory) {}

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
     * @dev Main mint - external function
     * @param data - data
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint the token
     */
    function mint(bytes memory data) external virtual onlyOwner {
        uint16 _nextId = totalSupplyId() + 1;
        require(_nextId <= MAX_SUPPLY_ID_V1, "Max supply exceeded");
        _totalSupplyId = _nextId;
        _mint(_msgSender(), _nextId, TOTAL_SUPPLY_PER_ID, data);
    }

    /**
     * @dev Main mintBatch - external function
     * @param _ids - number of tokenId to mint
     * @param data - data
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint tokens
     */
    function mintBatch(
        uint16 _ids,
        bytes memory data
    ) external virtual onlyOwner {
        uint256[] memory _idsBatch;
        uint256[] memory _amountsBatch;
        uint16 _nextId = _totalSupplyId + _ids;
        require(_nextId <= MAX_SUPPLY_ID_V1, "Max supply exceeded");
        _totalSupplyId += _nextId;
        for (uint16 i = 1; i <= _ids; ++i) {
            _idsBatch[i] = _totalSupplyId + i;
        }
        for (uint16 i = 1; i <= _ids; ++i) {
            _amountsBatch[i] = 10;
        }
        _mintBatch(_msgSender(), _idsBatch, _amountsBatch, data);
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
}
