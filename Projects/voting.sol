// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting{

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    mapping (address => bool) public hasVoted;

    Candidate[] public candidates;

    address public admin;

    event Voted(uint  candidateId, address voterAddress);

    constructor(){
        admin = msg.sender;
    } 

    modifier onlyAdmin(){
        require(admin == msg.sender,"Only admin call this function");
        _;
    }

    function addCandidate(string memory _name) public onlyAdmin{
        uint newId = candidates.length;
        candidates.push(Candidate(newId, _name,0));
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender],"You Have Already Voted");

        require( _candidateId < candidates.length,"Invalid candidate ID");

        hasVoted[msg.sender]= true;

        candidates[_candidateId].voteCount++;
    
    emit Voted(_candidateId, msg.sender);
    }

    function getCandidateCount() public view returns(uint){
        return candidates.length;
    }

    function getWinner() public view returns(string memory){
        uint maxVotes = 0;
        uint winnerIndex = 0;

        for(uint i =0; i < candidates.length;i++){
            if(candidates[i].voteCount > maxVotes){
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }
        if(maxVotes == 0){
            return "no vote cast yet";
        }
        else{
            return candidates[winnerIndex].name;
        }
    }
}