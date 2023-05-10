// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint public candidatesCount;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidates");
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _id) public {
        require(!voters[msg.sender], "You can only vote once");
        require(_id > 0 && _id <= candidatesCount, "Invalid candidate ID");
        candidates[_id].voteCount++;
        voters[msg.sender] = true;
    }

    function getWinner() public view returns (string memory) {
        uint maxVotes = 0;
        string memory winnerName;
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }
        return winnerName;
    }
}
