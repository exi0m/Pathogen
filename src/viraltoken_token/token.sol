pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";


/* Viral Token, basic token equipped with a liquidity pool that allows staking
*  to incentivize token holders to add to the liquidity pool for a reward.
*/

contract ViralToken is ERC20, ERC20Detailed{
    using SafeMath for uint256;


    address payable owner;
    uint public initial_supply;
    uint public pathogen_trust;
    uint public tvl;

    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permission to mint these tokens!");
        _;
    }
    
    /*
    * @notice The constructor for the Viral Token.
    * @param owner The address to receive all tokens on construction.
    * @param initial_supply The amount of tokens to mint on construction.
    * @param pathogen_trust The amount of tokens the Pathogen Trust is staking per liquidity pool
    */

    constructor() ERC20Detailed("ViralToken", "VIRAL", 18) public{
        owner  = msg.sender;
        initial_supply = 10000000; //10,000,000 supply
        pathogen_trust = 1000000; //$1,000,000 stake per pool by the Pathogen Trust
        tvl = 10000000;  // $10,000,000 Total Value Locked of liquidity per token
        _mint(owner, initial_supply);
    }
    
    function mint(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
    }
    
    
    
    address[] internal viral_stakeholders;    
    
    
    /**
    * @notice A method to check if an address is a stakeholder.
    * @param _address The address to verify.
    * @return bool, uint256 Whether the address is a stakeholder,
    * and if so its position in the stakeholders array.
    */
    
    function isStakeholder(address _address)
       public
       view
       returns(bool, uint256)
    {
       for (uint256 position = 0; position < viral_stakeholders.length; position += 1){
           if (_address == viral_stakeholders[position]) return (true, position);
       }
       return (false, 0);
    }

    /**
    * @notice A method to add a stakeholder.
    * @param _viral The stakeholder to add.
    */
    
    function addStakeholder(address _viral)
       public
    {
       (bool _isStakeholder, ) = isStakeholder(_viral);
       if(!_isStakeholder) viral_stakeholders.push(_viral);
    }

    /**
    * @notice A method to remove a stakeholder.
    * @param _viral The stakeholder to remove.
    */
    
    function removeStakeholder(address _viral)
       public
    {
       (bool _isStakeholder, uint256 position) = isStakeholder(_viral);
       if(_isStakeholder){
           viral_stakeholders[position] = viral_stakeholders[viral_stakeholders.length - 1];
           viral_stakeholders.pop();
       }
    }
   
    /**
    * @notice The stakes for each stakeholder.
    */
    
    mapping(address => uint256) internal stake_record;
   
    /**
    * @notice A method to retrieve the stake for a stakeholder.
    * @param _viral The stakeholder to retrieve the stake for.
    * @return uint256 The amount of wei staked.
    */
    
    function amountStaked(address _viral)
       public
       view
       returns(uint256)
    {
       return stake_record[_viral];
    }

    /**
    * @notice A method to the aggregated stakes from all stakeholders.
    * @return uint256 The aggregated stakes from all stakeholders.
    */
    
    function totalStakes()
       public
       view
       returns(uint256)
    {
       uint256 _aggregated_stakes = 0;
       for (uint256 position = 0; position < viral_stakeholders.length; position += 1){
           _aggregated_stakes = _aggregated_stakes.add(stake_record[viral_stakeholders[position]]);
       }
       return _aggregated_stakes;
    }
    

    /**
    * @notice A method for a stakeholder to create a stake.
    * @param _stake_size The size of the stake to be created.
    */
    
    function createStake(uint256 _stake_size)
       public
    {
       _burn(msg.sender, _stake_size);
       if(stake_record[msg.sender] == 0) addStakeholder(msg.sender);
       stake_record[msg.sender] = stake_record[msg.sender].add(_stake_size);
    }

    /**
    * @notice A method for a stakeholder to remove a stake.
    * @param _stake_size The size of the stake to be removed.
    */
    
    function removeStake(uint256 _stake_size)
       public
    {
       stake_record[msg.sender] = stake_record[msg.sender].sub(_stake_size);
       if(stake_record[msg.sender] == 0) removeStakeholder(msg.sender);
       _mint(msg.sender, _stake_size);
    }
   
    /**
    * @notice The accumulated rewards for each stakeholder.
    */
    
    mapping(address => uint256) internal rewards;
  
    /**
    * @notice A method to allow a stakeholder to check his rewards.
    * @param _viral The stakeholder to check rewards for.
    */
    
    function rewardOf(address _viral)
       public
       view
       returns(uint256)
    {
       return rewards[_viral];
    }

    /**
    * @notice A method to the aggregated rewards from all stakeholders.
    * @return uint256 The aggregated rewards from all stakeholders.
    */
    
    function totalRewards()
       public
       view
       returns(uint256)
    {  
       uint256 _totalRewards = 0;
       for (uint256 viral_reward = 0; viral_reward < viral_stakeholders.length; viral_reward += 1){
           _totalRewards = _totalRewards.add(rewards[viral_stakeholders[viral_reward]]);
       }
       return _totalRewards;
    }
   
   
    /**
    * @notice A simple method that calculates the rewards for each stakeholder.
    * @param _viral The stakeholder to calculate rewards for.
    */
    
    function calculateReward(address _viral)
       public
       view
       returns(uint256)
    {   
       return pathogen_trust/stake_record[_viral];
    }
   
   
    /**
    * @notice A method to distribute rewards to all stakeholders.
    */
    
    function distributeRewards()
       public
       onlyOwner
    {
       for (uint256 viral_reward = 0; viral_reward < viral_stakeholders.length; viral_reward += 1){
           address stakeholder_address = viral_stakeholders[viral_reward];
           uint256 reward = calculateReward(stakeholder_address);
           rewards[stakeholder_address] = rewards[stakeholder_address].add(reward);
       }
    }

    /**
    * @notice A method to allow a stakeholder to withdraw his rewards.
    */
    
    function withdrawReward()
       public
    {
       uint256 reward = rewards[msg.sender];
       rewards[msg.sender] = 0;
       _mint(msg.sender, reward);
    }
   
}
