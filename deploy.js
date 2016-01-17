var fs = require('fs');
var solc = require('solc');
var Web3 = require('web3');

var web3 = new Web3(new Web3.providers.HttpProvider(
    process.env.RPC_URL || 'http://localhost:8545'
));

var source = fs.readFileSync('Cactus.sol', 'utf8');
var output = solc.compile(source, 1);
var bytecode = '0x' + output.contracts.Cactus.bytecode;
var abi = JSON.parse(output.contracts.Cactus.interface);

var coinbase = web3.eth.coinbase;
if (process.env.PASSWORD) {
    web3.personal.unlockAccount(coinbase, process.env.PASSWORD, 300);
}

var Cactus = web3.eth.contract(abi);
Cactus.new({
    from: coinbase,
    data: bytecode,
    gas: 1200000
}, function (err, contract) {
    if (err) { console.error(err); return; }
    if (!contract.address) {
        console.log('tx: ' + contract.transactionHash);
    } else {
        console.log('Cactus deployed at ' + contract.address);
    }
});
