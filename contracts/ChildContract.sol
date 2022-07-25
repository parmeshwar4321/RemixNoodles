// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

        string public tokenName; //the token mame
        string public tokenSym //the token metadata URI

        constructor( string memory tokenName, string memory sym) ERC1155(_uri) {
                
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