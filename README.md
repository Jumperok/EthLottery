# Ethereum lottery

You can get some money if you are lucky enough ;)

## Getting Started

You have to do some steps to use this Dapp:

1) Download and extract Dapp folder from zip.
2) From console in Dapp folder type: 
```
npm install
```
after installing:
```
npm i ethereumjs-testrpc
```
after installing:
```
testrpc
```
3) Go to the http://remix.ethereum.org and past there text from Contract.sol
4) Choose Environment: Web3 Provider
5) Create contract, copy contract address, open index.html, and paste contract address to the
```
var Lottery = LotteryContract.at('our address');
```
6) Thats all. You can run the Dapp.

## Lottery Rules:

There are 5 tickets, 1 of them is winning. Ticket cost is 1 ether. One wallet can buy only one ticket. When all tickets are sold out, program choose a random number (1-5) and one of the participants get almost all money that others participants have spent.

## How to use Dapp:

If you want to change a wallet, buttons on top of the screen will help you.
To buy a ticket click on it then click "Buy" button. If a color of ticket turns grey, that means you buyed a ticket.
When last ticket will be bought, winner address should appear on the screen.




