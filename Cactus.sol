contract Cactus {
    struct Player {
        address addr;
        uint256 payout;
    }

    Player[] players;
    uint256 public payoutIndex;

    address creator;

    function Cactus() {
        creator = msg.sender;
    }

    function () {
        if (msg.value < 0.5 ether) throw;

        uint256 payout = msg.value * 120 / 100;
        players.push(Player(msg.sender, payout));

        while (payoutIndex < players.length && this.balance >= players[payoutIndex].payout) {
            if (!players[payoutIndex].addr.send(players[payoutIndex].payout)) throw;
            payoutIndex++;
        }
    }
}
