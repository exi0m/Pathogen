pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
* @title Pathogen Token (PATH)
* @notice Implements a basic ERC20 staking token with incentive distribution.
*/
contract StakingToken is ERC20, Ownable 
{
   using SafeMath for uint256;

   /**
    * @notice The constructor for the Staking Token.
    * @param _owner The address to receive all tokens on construction.
    * @param _supply The amount of tokens to mint on construction.
    */
   constructor(address _owner, uint256 _supply) public
   {
       _mint(_owner, _supply);
   }
    /* Initializes an array of stakeholders addresses 
    _stakeholder_address is a unique address,
    pathogen is an array of addresses */
    address[] internal pathogen;

    /* Checks if the "_stakeholder_address" is a valid stakeholder address */
    function is_stakeholder (address _stakeholder_address) public view returns (uint bool, uint256)
    {
        /* p is the address' position in the 'pathogen' array.  
        if the position number of p is less than the array's length,
        increment the count of p */
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

    // adds a stakeholder. Aman has used '_pathogen' in place of '_stakeholder' from the template. So, '_pathogen' will be used for consistency.
    // '_pathogen' is the address of stakeholder to be added
    function add_stakeolder (address _pathogen) public
    {
        // The new address '_pathogen' is passed to 'is_stakeholder' function, which performs the same steps as above
        // The boolean variable '_new_stakeholder' is defined to check if the '_pathogen' address belongs to the 'pathogen' array
        (bool _new_stakeholder, )= is_stakeholder(_pathogen);

        // if not true, then add the '_pathogen' address to the 'pathogen' array.
        if (!_new_stakeholder) pathogen.push(_pathogen); 
    }

    // remove a stakeholder
    function remove_stakeholder (address _pathogen) public
    {
        // The new address '_pathogen' is passed to 'is_stakeholder' function
        // The boolean variable '_new_stakeholder' is defined to check if the '_pathogen' address belongs to the 'pathogen' array
        (bool _new_stakeholder, uint 256 position_number)= is_stakeholder(_pathogen);

        // if the '_pathogen' address belongs to the 'pathogen' array,
        if (_new_stakeholder) 
        {
            // the desired address' position number is the length of the pathogen array minus 1
            pathogen[position_number]= pathogen[pathogen.length- 1];

            // removes the desired stakeholder's address.
            pathogen.pop();
        }
    }