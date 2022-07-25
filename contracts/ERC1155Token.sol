// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ERC1155Token is ERC1155, Ownable {
        string[] public names; //string array of names
        uint256[] public ids; //uint array of ids
        string public baseMetadataURI; //the token metadata URI
        string public name; //the token mame
        uint256 public mintFee = 0 wei; //mintfee, 0 by default. only used in mint function, not batch.

        mapping(string => uint256) public nameToId; //name to id mapping
        mapping(uint256 => string) public idToName; //id to name mapping
        mapping(address => bool) private allowedList;// allowed address to bool
        constructor( string memory _contractName, string memory _uri, string[] memory _names , uint256[] memory _ids) ERC1155(_uri) {
                
                names = _names;
                ids = _ids;
                createMapping();
                setURI(_uri);
                baseMetadataURI = _uri;
                name = _contractName;
                transferOwnership(tx.origin);
    }

    
        function createMapping() private {
            for (uint256 id = 0; id < ids.length; id++) {
                nameToId[names[id]] = ids[id];
                idToName[ids[id]] = names[id];
                }
        }


        function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
        }

        function uri(uint256 _tokenid)public view override returns (string memory){
        return string(
                abi.encodePacked(
                    baseMetadataURI,
                    Strings.toString(_tokenid),
                    ".json"
                )); 
        }

        function mint( address account,uint256 tokenid, uint256 amount,bytes memory metaData) public payable returns (uint256) {
                require(msg.value == mintFee, "mint fee is less");
                _mint(account, tokenid, amount, metaData);
                        return tokenid;
        }
        
   



}