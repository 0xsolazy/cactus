contract Cactus {
    address creator;

    function Cactus() {
        creator = msg.sender;
    }
}
