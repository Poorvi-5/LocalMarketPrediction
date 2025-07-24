function getUserPredictions(address _user) external view returns (Prediction[] memory) {
    uint256[] memory indices = userPredictions[_user];
    uint256 totalPredictions;

    // Count total predictions
    for (uint256 i = 0; i < marketCounter; i++) {
        totalPredictions += marketPredictions[i].length;
    }

    // Determine how many predictions belong to the user
    uint256 count = 0;
    for (uint256 i = 0; i < marketCounter; i++) {
        for (uint256 j = 0; j < marketPredictions[i].length; j++) {
            if (marketPredictions[i][j].predictor == _user) {
                count++;
            }
        }
    }

    // Collect user predictions
    Prediction[] memory predictions = new Prediction[](count);
    uint256 index = 0;
    for (uint256 i = 0; i < marketCounter; i++) {
        for (uint256 j = 0; j < marketPredictions[i].length; j++) {
            if (marketPredictions[i][j].predictor == _user) {
                predictions[index++] = marketPredictions[i][j];
            }
        }
    }

    return predictions;
}
