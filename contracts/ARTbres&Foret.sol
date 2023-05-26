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

_____________________________ __ ______  _______________________________________

________________________________________________________________________________
*/

/// @custom:security-contact enzo.jakobasch@gmail.com
contract ARTbres_Forets is
    Initializable,
    UUPSUpgradeable,
    ERC1155Upgradeable,
    OwnableUpgradeable
{
    using StringsUpgradeable for uint256;
    uint256 public totalSupply;
    uint16 private constant MAXSUPPLY = 10000;
    uint16 private constant MAXSUPPLY_V1 = 1000;
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
        return _ownerOf(_tokenId) != address(0);
    }

    function name() external view virtual returns (string memory) {
        return NAME;
    }

    function symbol() external view virtal returns (string memory) {
        return SYMBOL;
    }

    function maxSupply() public view virtual returns (uint256) {
        return MAXSUPPLY;
    }

    function maxSupply_V1() public view virtual returns (uint256) {
        return MAXSUPPLY_V1;
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
     * @param _ids - array of number of tokenId to mint
     * @param _amounts - array of number of each tokenId to mint
     * @param data - data
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint tokens
     */
    function mintBatch(
        uint256[] calldata _ids,
        uint256[] calldata _amounts,
        bytes memory data
    ) external virtual onlyOwner {
        uint16 number = _ids.length;
        require(+number <= maxSupply, "Max supply exceeded");
        totalSupply += number;
        _mintBatch(_msgSender(), _ids, _amounts, data);
    }

    /**
     * @dev Main mint - external function
     * @param _ids - number of tokenId to mint
     * @param _amounts - number of each tokenId to mint
     * @param data - data
     *  - Verify that the caller is the owner
     *  - Verify that total supply + quantity is less than maxSupply
     *  - Mint the token
     */
    function mint(
        uint256 calldata _ids,
        uint256 calldata _amounts,
        bytes memory data
    ) external virtual onlyOwner {
        ++totalSupply;
        _mint(_msgSender(), _ids, _amounts, data);
    }
}
