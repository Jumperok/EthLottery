pragma solidity ^0.4.11;

contract Lottery {
  
    address owner;
    uint8 soldTicketsAmount;
    uint8 public winningTicketNumber;
    address[] winnersAddresses;
    uint8[] buyedTickets;
    uint ticketPrice;
    uint fee;
    uint ticketsAmount;
    
    struct User {
        address userAddress;
        uint balance;
    }
    
    mapping(uint => User) public participates;
    
    event TicketInfo(uint8 _ticketNumber, uint8 _soldTicketsAmount);
    event Winner(address _winner);
    
    function getWinners() constant returns(address[]){
        return winnersAddresses;
    }
    
    function getBuyedTickets() constant returns(uint8[]){
        return buyedTickets;
    }

    function Lottery() {
        soldTicketsAmount = 0;
        owner = msg.sender;
        ticketPrice = 1 ether;
        fee = 0.01 ether;
        ticketsAmount = 5;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function getAddr(uint8 num) constant returns(address) {
        return participates[num].userAddress;       
    }
    
    function participateLottery(uint8 ticketNumber) payable returns (bool) {

        require(participates[ticketNumber].userAddress == address(0));
        
        if(msg.value < ticketPrice){
            return false;
        }
        
        participates[ticketNumber].balance = ticketPrice-fee;
        participates[ticketNumber].userAddress = msg.sender;
        buyedTickets.push(ticketNumber);
        
        if(msg.value > ticketPrice){    
            msg.sender.transfer(msg.value - ticketPrice);    
        }
        soldTicketsAmount++;
        TicketInfo(ticketNumber, soldTicketsAmount);
        if(soldTicketsAmount == ticketsAmount) {
            winningTicketNumber = uint8(block.blockhash(block.number-1))%soldTicketsAmount+1;
            participates[winningTicketNumber].userAddress.transfer(5*(ticketPrice-fee));
            Winner(participates[winningTicketNumber].userAddress);
            winnersAddresses.push(participates[winningTicketNumber].userAddress);
            for(uint8 i = 1; i<soldTicketsAmount+1; i++){
                participates[i].userAddress = address(0);
            }
            buyedTickets.length = 0;
            soldTicketsAmount = 0;
            return true;
        }
        return true;
    }

    function withdraw(uint amount) onlyOwner returns(bool) {
        require(this.balance>amount);
        msg.sender.transfer(amount);
        return true;
    }
    
    function getContractValue() constant returns(uint256) {
        return this.balance;
    }
    
    function() payable {
        for(uint8 i =1; i<6; i++){
            if(getAddr(i)==address(0)){
               participateLottery(i);
               break;
            }
        }
    }
}