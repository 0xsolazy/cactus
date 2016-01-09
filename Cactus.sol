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
}
