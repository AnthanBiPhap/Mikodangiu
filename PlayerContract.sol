// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlayerManager {
    struct Player {
        uint256 id;       // Player's ID
        string name;      // Player's name
        uint8 heart;      // Player's heart count (HEART)
        uint8 strength;   // Player's strength (STRENG)
    }

    // Mapping from the player's address to their Player data
    mapping(address => Player) public players;

    // Event when player information is added or updated
    event PlayerAdded(address indexed playerAddress, uint256 id, string name, uint8 heart, uint8 strength);
    event PlayerUpdated(address indexed playerAddress, uint256 id, string name, uint8 heart, uint8 strength);

    // Add a new player
    function addPlayer(uint256 _id, string memory _name, uint8 _heart, uint8 _strength) public {
        // Check if the player already exists
        require(bytes(players[msg.sender].name).length == 0, "Player already exists.");
        
        players[msg.sender] = Player(_id, _name, _heart, _strength);
        emit PlayerAdded(msg.sender, _id, _name, _heart, _strength);
    }

    // Update an existing player's information
    function updatePlayer(uint256 _id, string memory _name, uint8 _heart, uint8 _strength) public {
        // Ensure that the player exists before updating
        require(bytes(players[msg.sender].name).length > 0, "Player does not exist.");
        
        players[msg.sender] = Player(_id, _name, _heart, _strength);
        emit PlayerUpdated(msg.sender, _id, _name, _heart, _strength);
    }

    // Get player's information (ID, name, heart, strength)
    function getPlayer() public view returns (uint256 id, string memory name, uint8 heart, uint8 strength) {
        Player memory player = players[msg.sender];
        return (player.id, player.name, player.heart, player.strength);
    }

    // Remove player's information
    function removePlayer() public {
        // Ensure that the player exists before removing
        require(bytes(players[msg.sender].name).length > 0, "Player does not exist.");
        
        delete players[msg.sender];
    }

    // Check if a player exists
    function playerExists(address _playerAddress) public view returns (bool) {
        return bytes(players[_playerAddress].name).length > 0;
    }
}
