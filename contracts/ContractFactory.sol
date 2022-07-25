//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.1;

import "./metaToken.sol";

contract ContractFactory {
        ERC1155Token[] public contracts;

function createContract(string memory _name, string memory _symbol, string memory _baseURI,bool _allowsTransfers) public{

        ERC1155Token token=new ERC1155Token(_name,_symbol,_baseURI,_allowsTransfers);
        contracts.push(token);

}

function getContract(uint _index ) public view 
returns(address contractAddress,
         string memory name, 
         string memory symbol, 
         string memory baseURI
         )
        {

        ERC1155Token token = contracts[_index];

        return (token.contractAddress(),token.name(),token.symbol(),token.baseURI());
}

}