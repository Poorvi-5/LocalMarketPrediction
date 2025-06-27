// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract LocalMarketPrediction {
    struct Market {
        uint256 id;
        string description;
        uint256 endTime;
        bool resolved;
        bool outcome;
        uint256 totalYesStake;
        uint256 totalNoStake;
        address creator;
    }

    struct Prediction {
        uint256 marketId;
        address predictor;
        bool prediction;
        uint256 stake;
        bool claimed;
    }

    mapping(uint256 => Market) public markets;
    mapping(uint256 => Prediction[]) public marketPredictions;
    mapping(address => uint256[]) public userPredictions;
    
    uint256 public marketCounter;
    uint256 public constant MIN_STAKE = 0.01 ether;
    uint256 public constant PLATFORM_FEE = 5; // 5%
    
    address public owner;
    uint256 public platformBalance;

    event MarketCreated(uint256 indexed marketId, string description, uint256 endTime, address creator);
    event PredictionMade(uint256 indexed marketId, address indexed predictor, bool prediction, uint256 stake);
    event MarketResolved(uint256 indexed marketId, bool outcome);
    event RewardClaimed(uint256 indexed marketId, address indexed winner, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier marketExists(uint256 _marketId) {
        require(_marketId < marketCounter, "Market does not exist");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createMarket(string memory _description, uint256 _duration) external {
        require(bytes(_description).length > 0, "Description cannot be empty");
        require(_duration > 0, "Duration must be positive");
        
        uint256 marketId = marketCounter++;
        uint256 endTime = block.timestamp + _duration;
        
        markets[marketId] = Market({
            id: marketId,
            description: _description,
            endTime: endTime,
            resolved: false,
            outcome: false,
            totalYesStake: 0,
            totalNoStake: 0,
            creator: msg.sender
        });
        
        emit MarketCreated(marketId, _description, endTime, msg.sender);
    }

    function makePrediction(uint256 _marketId, bool _prediction) external payable marketExists(_marketId) {
        require(msg.value >= MIN_STAKE, "Stake must be at least minimum amount");
        require(block.timestamp < markets[_marketId].endTime, "Market has ended");
        require(!markets[_marketId].resolved, "Market already resolved");
        
        marketPredictions[_marketId].push(Prediction({
            marketId: _marketId,
            predictor: msg.sender,
            prediction: _prediction,
            stake: msg.value,
            claimed: false
        }));
        
        userPredictions[msg.sender].push(marketPredictions[_marketId].length - 1);
        
        if (_prediction) {
            markets[_marketId].totalYesStake += msg.value;
        } else {
            markets[_marketId].totalNoStake += msg.value;
        }
        
        emit PredictionMade(_marketId, msg.sender, _prediction, msg.value);
    }

    function resolveMarket(uint256 _marketId, bool _outcome) external onlyOwner marketExists(_marketId) {
        require(block.timestamp >= markets[_marketId].endTime, "Market has not ended yet");
        require(!markets[_marketId].resolved, "Market already resolved");
        
        markets[_marketId].resolved = true;
        markets[_marketId].outcome = _outcome;
        
        emit MarketResolved(_marketId, _outcome);
    }

    function claimReward(uint256 _marketId, uint256 _predictionIndex) external marketExists(_marketId) {
        require(markets[_marketId].resolved, "Market not resolved yet");
        require(_predictionIndex < marketPredictions[_marketId].length, "Invalid prediction index");
        
        Prediction storage prediction = marketPredictions[_marketId][_predictionIndex];
        require(prediction.predictor == msg.sender, "Not your prediction");
        require(!prediction.claimed, "Reward already claimed");
        require(prediction.prediction == markets[_marketId].outcome, "Incorrect prediction");
        
        prediction.claimed = true;
        
        uint256 totalPool = markets[_marketId].totalYesStake + markets[_marketId].totalNoStake;
        uint256 winningPool = markets[_marketId].outcome ? markets[_marketId].totalYesStake : markets[_marketId].totalNoStake;
        
        uint256 reward = (prediction.stake * totalPool) / winningPool;
        uint256 fee = (reward * PLATFORM_FEE) / 100;
        uint256 finalReward = reward - fee;
        
        platformBalance += fee;
        
        payable(msg.sender).transfer(finalReward);
        
        emit RewardClaimed(_marketId, msg.sender, finalReward);
    }

    function getMarketDetails(uint256 _marketId) external view marketExists(_marketId) returns (Market memory) {
        return markets[_marketId];
    }
}
