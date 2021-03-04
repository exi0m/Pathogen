pragma solidity ^0.5.17;

import "https://github.com/ConsenSysMesh/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
// import "https://github.com/ConsenSysMesh/openzeppelin-solidity/blob/master/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/ConsenSysMesh/openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";
import "https://github.com/ConsenSysMesh/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "https://github.com/ConsenSysMesh/openzeppelin-solidity/contracts/math/SafeMath.sol";

/* Pathogen Token (PATH)
Implements a basic ERC20 staking token with incentive distribution */

contract StakingToken is ERC20, Ownable , BurnableToken
{
   using SafeMath for uint256;

   /* The constructor for the Staking Token.
    _owner The address to receive all tokens on construction.
     _supply The amount of tokens to mint on construction */
     
   constructor(address _owner, uint256 _supply) public
   {
       _mint(_owner, _supply);
   }
    /* Initializes an array of stakeholders addresses 
    _stakeholder_address is a unique address,
    pathogen is an array of addresses */
    address[] internal pathogen;

    /* Checks if the "_stakeholder_address" is a valid stakeholder address */
    function is_stakeholder (address _stakeholder_address) public view returns (bool, uint256)
    {
        /* position_number is the address' position in the 'pathogen' array.  
        if the position number is less than the array's length,
        increment the count of position_number */
        for (uint256 position_number=0; position_number< pathogen.length; position_number += 1)
        {   
            /* if the '_stakeholder_address' address is a valid stakeholder, 
            the address' position number in the 'pathogen' array is returned */
            if (_stakeholder_address== pathogen[position_number]) return (true, position_number);
        }
        /* if the '_stakeholder_address' address is invalid,
        then return zero */
        return (false, 0);
    }

    // adds a stakeholder
    // '_pathogen' is the address of stakeholder to be added
    function add_stakeholder (address _pathogen) public
    {
        bool _new_stakeholder;
        // The new address '_pathogen' is passed to 'is_stakeholder' function, which performs the same steps as above
        // The boolean variable '_new_stakeholder' is defined to check if the '_pathogen' address belongs to the 'pathogen' array
        
        (_new_stakeholder, )= is_stakeholder(_pathogen);

        // if not true, then add the '_pathogen' address to the 'pathogen' array.
        if (!_new_stakeholder) pathogen.push(_pathogen); 
    }

    // remove a stakeholder
    function remove_stakeholder (address _pathogen) public
    {
        bool _new_stakeholder;
        uint position_number;
        // The new address '_pathogen' is passed to 'is_stakeholder' function
        // The boolean variable '_new_stakeholder' is defined to check if the '_pathogen' address belongs to the 'pathogen' array
        
        (_new_stakeholder, position_number)= is_stakeholder(_pathogen);

        // if the '_pathogen' address belongs to the 'pathogen' array,
        if (_new_stakeholder) 
        {
            // the desired address' position number is the length of the pathogen array minus 1
            pathogen[position_number]= pathogen[pathogen.length- 1];

            // removes the desired stakeholder's address.
            pathogen.pop();
        }
    }

// ================================================================================================================  
//   STAKING  
    /* A stake_record mapping function is defined to record the stake size and the respective stakeholder */
    /* The address of the stakeholder is mapped to their respective stake size */
    mapping (address => uint256) public stake_record;
    
    /* A function is defined that will return the amount of PATH staked by the respective stakeholder */
    function amount_staked (address _pathogens) public view returns (uint256)
    {
        return stake_record(_pathogens);
    }
    
    /* The function below aggregates the stakes from all the respective stakeholders 
    The total count of stakes in the pathogen array is returned*/
    function total_stake () public view returns (uint256)
    {
        uint256 _aggregated_stakes= 0;
        /* position_number is the address' position in the pathogen array 
        if the position number is less than the pathogen array's length,
        increment the position_number*/
        
        for (uint position_number= 0; position_number < pathogen.length; position_number += 1)
        {
            _aggregated_stakes= _aggregated_stakes.add(stake_record[pathogen[position_number]]);
        }
        return _aggregated_stakes;
    }
    
    /* There needs to be a functionality to create and remove stakes 
    In order to ensure a stakeholder does not rig/ manipulate the liquidity pool,
    the necessary steps to prevent those are taken*/
    
    /* A stake is created here */
    function create_stake (uint256 _stake_size) public 
    {
        /* if a stakeholder tries to stake more coins than they own,
        _burn will revert the stake creation */
        _burn (msg.sender, _stake_size);
    
        /* if the number of stakes of a particular stakeholder equals zero, 
        add the stakeholder to the 'pathogen' array*/
        if (stake_record[msg.sender]== 0) add_stakeholder(msg.sender);
    
        // increment the _stake_size in the stake_record
        stake_record[msg.sender]= stake_record[msg.sender].add(_stake_size);
    }
    
    /* A stake is purged if the stakeholder removes more token than they staked */
    function remove_stake (uint256 _stake_size) public
    {
        /* Decrement the _stake_size from stake_record*/
        stake_record[msg.sender]= stake_record[msg.sender].sub(_stake_size);
        
        /* remove the stakeholder */
        if (stake_record[msg.sender]== 0) remove_stakeholder(msg.sender);
        _mint (msg.sender, _stake_size);
    }
    // ====================================================================================================
    // REWARDS
    /*The accumulated rewards for each Token */
    
    /* A rewards mapping object is created */
    mapping(address => uint256) internal rewards;
    
    /* Define a function that will take an address and
    pass it to the rewards mapping object. Any stakeholder
    can check their rewards in this function */

    function check_rewards(address _pathogen)
        public
        view
        returns(uint256)      
    {
        return rewards(_pathogen);      
    }  

    /* Calcualte the aggregated rewards from all tokens
    and return the aggregated rewards */

    function total_rewards()
        public
        view
        returns(uint256)    
    {
        /* the reward for the pathogen token is 0.2 percent
        use path_reward as the variable to iterate over the pathogen array */

        uint256 _aggregated_reward = 0;
        for (uint256 path_reward = 0; path_reward < pathogen.length; path_reward += 0.2)
        {
            _aggregated_reward = _aggregated_reward.add(rewards[pathogen[path_reward]]);
            
        }     
        return _aggregated_reward;
    }
        
    /* calculate the rewards for each Token */
    
    function calculate_reward(address _pathogen)
        public
        view
        returns(uint256)  
    {
        return stake_record(_pathogen) /100;
        
    } 
    
    /* Distribute rewards to all Tokens */
    function distribute_rewards() public only_owner       
    {
        for (uint256 path_reward= 0; path_reward < pathogen.length; path_reward += 0.2)
        {
            /* for all the addresses in the pathogen array, distribute a 0.2 percent reward */
            address rewarding_address = pathogen[path_reward];
            uint256 given_reward = calculate_reward(rewarding_address);

            /* all the addresses that receive the reward are added
            to the 'rewards' mapping object */
            rewards[rewarding_address] = rewards[rewarding_address].add(given_reward);
        }
    }
    
    /* function to withdraw stakeholder's rewards */  
    function withdraw_reward() public       
    {
        uint256 rewarding_address = rewards[msg.sender];
        rewards[msg.sender] = 0;
        _mint(msg.sender, rewarding_address);      
    }
}