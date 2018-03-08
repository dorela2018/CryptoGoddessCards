pragma solidity ^0.4.18;

// @title A facet of CardCore that manages special access privileges.
// @author Fancy Dorela (goddesscards@hotmail.com)
// @dev See the CardCore contract documentation to understand how the various contract facets are arranged.
contract CardAccessControl {
    // This facet controls access control for Crypto Goddess Cards. There are simple roles managed all:
    //
    //     - The CEO: The CEO can reassign other roles and change the addresses of our dependent smart
    //         contracts. It is also the only role that can unpause the smart contract. It is initially
    //         set to the address that created the smart contract in the CardCore constructor. 
    //         CEO provide wallet address in exchange market. All kinds of in-site transaction (with lower 
    //		   gas and more rapid response) should be published only by CEO. 
    //
    // It should be noted that these roles are distinct without overlap in their access abilities, the
    // abilities listed for each role above are exhaustive. 

    /// @dev Emited when contract is upgraded - See README.md for updgrade plan
    event ContractUpgrade(address newContract);

    // The addresses of the accounts (or contracts) that can execute actions within each roles.
    address public ceoAddress;

    // @dev Keeps track whether the contract is paused. When that is true, most actions are blocked
    bool public paused = false;

    /// @dev Access modifier for CEO-only functionality
    modifier onlyCEO() {
        require(msg.sender == ceoAddress);
        _;
    }

    /// @dev Assigns a new address to act as the CEO. Only available to the current CEO.
    /// @param _newCEO The address of the new CEO
    function setCEO(address _newCEO) public onlyCEO {
        require(_newCEO != address(0));

        ceoAddress = _newCEO;
    }

    function withdrawBalance() external onlyCEO {
        ceoAddress.transfer(this.balance);
    }

    /// @dev Modifier to allow actions only when the contract IS NOT paused
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /// @dev Modifier to allow actions only when the contract IS paused
    modifier whenPaused {
        require(paused);
        _;
    }

    /// @dev Called by CEO role to pause the contract in necessary.
    function pause() public onlyCEO whenNotPaused {
        paused = true;
    }

    /// @dev Unpauses the smart contract, only called by CEO.
    function unpause() public onlyCEO whenPaused {
        paused = false;
    }
}
