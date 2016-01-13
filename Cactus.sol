contract Cactus {
    struct Player {
        address addr;
        uint256 payout;
    }

    Player[] players;
    uint256 public payoutIndex;
    uint256 public collectedFees;

    uint256 ownerFee = 5;

    address creator;

    function Cactus() {
        creator = msg.sender;
    }

    function () {
        if (msg.value < 0.5 ether) throw;

        collectedFees += msg.value * ownerFee / 100;

        uint256 payout = msg.value * 120 / 100;
        players.push(Player(msg.sender, payout));

        while (payoutIndex < players.length && this.balance >= collectedFees + players[payoutIndex].payout) {
            if (!players[payoutIndex].addr.send(players[payoutIndex].payout)) throw;
            payoutIndex++;
        }
    }
}
