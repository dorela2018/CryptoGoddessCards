pragma solidity ^0.4.18;

import "./CardMinting.sol";
import "./CardOwnership.sol";

// @title Crypto Goddess Cards: Collectible, combinable and competive on the Ethereum blockchain.
// @author Fancy Dorela (goddesscards@hotmail.com)
// @dev The main Crypto Goddess Cards contract, keeps track of cards.
contract CardCore is CardMinting, CardOwnership {
    // This is the main CryptoCards contract. Cards can be obtained, consigned and combined 
    //    to generate a new one. The genetic combination algorithm is in CardGeneScience.sol, which determines
    //		 the gen of next generation.
    //      - CardBase: This is where we define the most fundamental code shared throughout the core
    //             functionality. This includes our main data storage, constants and data types, plus
    //             internal functions for managing these items.
    //      - CardAccessControl: This contract manages the various addresses and constraints for operations
    //             that can be executed only by specific roles. Namely CEO.
    //      - CardOwnership: This provides the methods required for basic non-fungible token
    //             transactions, following the draft ERC-721 spec (https://github.com/ethereum/EIPs/issues/721).
    //      - CardMinting: This facet contains the functionality we use for creating new gen0 cards and the limit of gen0 is set 
    //             to 10 million. After that, it's all up to the community to create much more power and precious cards by combination!

    // Set in case the core contract is broken and an upgrade is required
    address public newContractAddress;

    // @notice Creates the main Crypto Goddess Cards smart contract instance.
    function CardCore(uint64 _now) public {
        // Starts paused.
        paused = true;
        
        // the creator of the contract is also the initial CEO
        ceoAddress = msg.sender;

        // start with the mythical card 0 Nuva - so we don't have generation-0 parent issues
        _createCard(0, 0, uint128(-1), address(0), _now);
    }

    // @dev Used to mark the smart contract as upgraded, in case there is a serious
    //  breaking bug. This method does nothing but keep track of the new contract and
    //  emit a message indicating that the new address is set. It's up to clients of this
    //  contract to update to the new contract address in that case. (This contract will
    //  be paused indefinitely if such an upgrade takes place.)
    function setNewAddress(address _v2Address) public onlyCEO whenPaused {
        // See README.md for updgrade plan
        newContractAddress = _v2Address;
        ContractUpgrade(_v2Address);
    }

    // @dev Reject all Ether from being sent here, unless it's from one of the
    //  two auction contracts. (Hopefully, we can prevent user accidents.)
    function() external payable {
        require(
            msg.sender == ceoAddress
        );
    }

    // @notice Returns all the relevant information about a given card.
    // @param _id The ID of the card.
    function getCard(uint256 _id)
        public
        view
        returns (
        bool isGestating,
        uint256 combinationId,
        uint256 createTime,
        uint256 mId,
        uint256 fId,
        uint128 genes
    ) {
        Card storage card = cards[_id];

        // if this variable is 0 then it's not gestating
        isGestating = (card.combinationId != 0);        
        combinationId = uint256(card.combinationId);
        createTime = uint256(card.createTime);
        mId = uint256(card.mId);
        fId = uint256(card.fId);
        genes = card.genes;
    }

    /// @dev Override unpause so it requires all external contract addresses
    ///  to be set before contract can be unpaused. Also, we can't have
    ///  newContractAddress set either, because then the contract was upgraded.
    function unpause() public onlyCEO whenPaused {
        require(newContractAddress == address(0));
        super.unpause();
    }    
}
