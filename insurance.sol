//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract TechInsurance is ERC721("NinjaToekn","Ninja") {
    
    /** 
     * Defined two structs
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

    modifier OnlyinsOwner {
        require(msg.sender == Owner);
        _;
        
    }


    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    uint productCounter;

    address payable insOwner;

    //constructor(address payable ) public{
     //insOwner = msg.sender;
    //}
 
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
      productCounter++;
      address insOwner  = msg.sender; 
      productIndex [productCounter] = Product (_productId , _productName , _price , true);
       
    
    }

     contract MyToken is ERC721{
   function _mint(address to, uint256 tokenId) internal  {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");
    
        _balances[to] += 1;
        _owners[tokenId] = to;
       emit Transfer(address(0), to, tokenId);
    }
  } 
    
    function doNotOffer(uint _productIndex) public returns(bool) {
        require(msg.sender == insOwner,"No Offer");
        return productIndex[_productIndex].offered = false;

    }
    
    function forOffer(uint _productIndex) public returns(bool) {
        require(msg.sender == insOwner,"Yes Offer");
        productIndex[_productIndex].offered = true;

    }
    
    function changePrice(uint _productIndex, uint _price) public view {
        require( productIndex[_productIndex].price>=1);
        productIndex[_productIndex].price==_price;
    }
  
    
    function buyInsurance(uint _productIndex) public payable {
        require( productIndex[_productIndex].price == msg.value);
        doNotOffer(_productIndex);
        Client memory NewClient;
        NewClient.isValid=true;
        client[msg.sender][_productIndex]= NewClient;
        payable(msg.sender).transfer(msg.value);
    } 
      function transferID( address to, uint256 tokenId) public  {
        require(ownerOf(tokenId) == msg.sender,"only owner" );
        _transfer(msg.sender, to, tokenId);
    }
    

    
  

