# LocalMarketPrediction

## Project Description

LocalMarketPrediction is a decentralized prediction market platform built on the Core Blockchain that enables users to create and participate in local market predictions. The platform allows community members to forecast outcomes of local events, business performances, or market trends within their geographic area, fostering a collaborative environment for local economic insights.

Users can create prediction markets for various local scenarios such as "Will the new restaurant downtown succeed in its first year?" or "Will local housing prices increase by 10% next quarter?" Participants stake cryptocurrency on their predictions, and winners receive rewards proportional to their stake and the accuracy of their predictions.

## Project Vision

Our vision is to democratize local market intelligence by creating a transparent, community-driven platform where residents can collectively predict and analyze local economic trends. By leveraging blockchain technology, we ensure fair, transparent, and tamper-proof prediction markets that benefit entire communities through shared knowledge and economic participation.

We aim to bridge the gap between local market knowledge and formal economic forecasting, empowering communities to make informed decisions about local investments, business ventures, and economic planning.

## Key Features

### Smart Contract Functionality
- **Market Creation**: Users can create prediction markets with custom descriptions and time durations
- **Prediction Staking**: Participants can stake cryptocurrency on Yes/No outcomes with a minimum stake requirement
- **Automated Resolution**: Market outcomes are resolved by the contract owner after the prediction period ends
- **Reward Distribution**: Winners automatically receive proportional rewards based on their stake and total pool
- **Platform Fee System**: 5% platform fee on winnings to maintain the ecosystem

### Technical Features
- **Secure Staking**: Minimum stake of 0.01 CORE tokens ensures serious participation
- **Transparent Tracking**: All predictions and outcomes are recorded on-chain
- **User Portfolio**: Track individual prediction history and performance
- **Gas Optimized**: Efficient contract design for cost-effective transactions
- **Owner Controls**: Administrative functions for market resolution and platform management

### User Experience
- **Simple Interface**: Easy-to-use functions for creating and participating in markets
- **Real-time Updates**: Blockchain-based tracking of market status and outcomes
- **Community Driven**: Local users create and participate in relevant prediction markets
- **Fair Rewards**: Proportional reward system based on prediction accuracy and stake size

## Future Scope

### Platform Enhancements
- **Mobile Application**: Develop native mobile apps for iOS and Android platforms
- **Advanced Analytics**: Implement prediction accuracy tracking and user reputation systems
- **Multi-token Support**: Enable predictions using various cryptocurrencies
- **Oracle Integration**: Automatic outcome resolution using external data sources
- **Governance Token**: Introduce platform governance tokens for community decision-making

### Feature Expansions
- **Category-based Markets**: Organize predictions by categories (real estate, business, events, etc.)
- **Social Features**: User profiles, leaderboards, and community discussions
- **Market Templates**: Pre-built market templates for common local prediction scenarios
- **Time-weighted Predictions**: Early prediction bonuses and dynamic reward structures
- **Cross-chain Compatibility**: Expand to multiple blockchain networks

### Business Development
- **Partnership Program**: Collaborate with local businesses and chambers of commerce
- **Educational Resources**: Provide guides and tutorials for prediction market participation
- **API Development**: Enable third-party integrations and data access
- **Insurance Integration**: Prediction markets for local business insurance and risk assessment
- **Government Partnerships**: Municipal prediction markets for public policy outcomes

## Contract Details

### Deployment Information
- **Contract Name**: LocalMarketPrediction
- **Solidity Version**: ^0.8.17
- **Network**: Core Blockchain Testnet
- **Chain ID**: 1114
- **RPC URL**: https://rpc.test2.btcs.network

### Contract Parameters
- **Minimum Stake**: 0.01 CORE tokens
- **Platform Fee**: 5% of winnings
- **Gas Optimization**: Efficient storage and computation patterns
- **Security Features**: Reentrancy protection and input validation

### Main Functions
1. **createMarket(string _description, uint256 _duration)**: Create new prediction markets
2. **makePrediction(uint256 _marketId, bool _prediction)**: Stake on market outcomes
3. **resolveMarket(uint256 _marketId, bool _outcome)**: Resolve market outcomes (owner only)
4. **claimReward(uint256 _marketId, uint256 _predictionIndex)**: Claim winnings for correct predictions
5. **getMarketDetails(uint256 _marketId)**: Retrieve market information and statistics

### Events
- **MarketCreated**: Emitted when new markets are created
- **PredictionMade**: Logged when users make predictions
- **MarketResolved**: Triggered when outcomes are determined
- **RewardClaimed**: Recorded when winners claim their rewards

### Deployment Instructions
1. Ensure your `.env` file contains a valid PRIVATE_KEY
2. Install dependencies: `npm install`
3. Compile contracts: `npx hardhat compile`
4. Deploy to Core Testnet: `npx hardhat run scripts/deploy.js --network coreTestnet`
5. Verify deployment and note the contract address for frontend integration

### Security Considerations
- All market resolutions require owner authorization
- Minimum stake requirements prevent spam predictions
- Time-based restrictions ensure fair market participation
- Platform fee collection maintains ecosystem sustainability
