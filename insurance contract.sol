//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

import "../github/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "/.ERC721.sol";


/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
 
 
contract TechInsurance is ERC721("MyToken", "Ins") {
    
    /** 
     * Define two structs
     * 
     * 
     */
     
   
      
    struct Product {
        uint productId;
        string productName;
        uint price;
        bool offered;
    }
     
    struct Client {
        bool isValid;
        uint time;
    }
    
    mapping (uint256 => address) public _owner;
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
    mapping (uint256 => address) public _owners;
    mapping (address => uint256) public _balances;
  
  
  
    function balanceOf(address insowner) public view returns (uint256) {
        require(insowner != address(0));
        return _balances[insowner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address insowner = _owners[tokenId];
        require(insowner != address(0));
        return insowner;
    }
    
 
    function transferFrom(address from, address to, uint256 tokenId) public {
        require(insowner(msg.Sender(), tokenId), "not owner");

        _transfer(from, to, tokenId);
    }
    function _transfer(address from, address to, uint256 tokenId) public {
        require(ERC721.ownerOf(tokenId) == from);
        require(to != address(0));

        _beforeTokenTransfer(from, to, tokenId);
        _approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }
    
    
    
    
    uint productCounter;
    
    address payable insOwner;
    constructor(address payable _insOwner) public  {
        insOwner = _insOwner;
        
    }
    
    address public Owner;
    modifier OnlyOwner (){
        require( Owner == msg.sender, "you are not the owner");
        _;
    }
  
  
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
         
         
         Product memory newProduct = Product(_productId, _productName, _price, true);
         productCounter++;
         productIndex[productCounter++] = newProduct;
         
        
    }
    
    
    function doNotOffer(uint _productIndex) public {

        require (productIndex[_productIndex].offered = false, "the product is not covered");
        

    }
    
    function forOffer(uint _productIndex) public {
         require (productIndex[_productIndex].offered = true, "the product is covered");

    }
    
    function changePrice(uint _productIndex, uint _price) public OnlyOwner {
       
        //uint newPrice = _price;
        require (productIndex[_productIndex].price >= 1, "Price changed");
        
        productIndex[_productIndex].price = _price;
         

    }
    
    /**
    * @dev 
    * Every client buys an insurance, 
    * you need to map the client's address to the id of product to struct client, using (client map)
    */
    
    function buyInsurance(uint _productIndex) public payable {
        require (productIndex[_productIndex].price == msg.value, "Not correct");
        require (productIndex[_productIndex].price == 0, "not valid");
        Client memory AddClient;
        AddClient.isValid = true;
        AddClient.time = block.number;
        client[msg.sender][_productIndex] = AddClient;
        insOwner.transfer(msg.value);
       
    } 
    
  
    //uint256 public start = block.timestamp ;

    //function clientSelect( uint secAfter) public {
    //require(block.timestamp < start + secAfter * 10 days,"not allowed");
    
//}
    
}