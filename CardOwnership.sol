pragma solidity ^0.4.18;

import "./CardBase.sol";
import "./ERC721Draft.sol";

// @title The facet of the Crypto Goddess Cards core contract that manages ownership, ERC-721 (draft) compliant.
// @author Fancy Dorela (goddesscards@hotmail.com)
// @dev Ref: https://github.com/ethereum/EIPs/issues/721
//  See the CardCore contract documentation to understand how the various contract facets are arranged.

contract CardOwnership is CardBase, ERC721 {
    /// @notice Name and symbol of the non fungible token, as defined in ERC721.
    string public name = "CryptoGoddessCards";
    string public symbol = "GERC";

    // bool public implementsERC721 = true;
    function implementsERC721() public pure returns (bool)
    {
        return true;
    }
    
    // Internal utility functions: These functions all assume that their input arguments
    // are valid. We leave it to public methods to sanitize their inputs and follow
    // the required logic.

    /// @dev Checks if a given address is the current owner of a particular card.
    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return cardIndexToOwner[_tokenId] == _claimant;
    }

    /// @dev Transfers a card owned by this contract to the specified address.
    ///  Used to rescue lost cards. (There is no "proper" flow where this contract
    ///  should be the owner of any card. This function exists for us to reassign
    ///  the ownership of cards that users may have accidentally sent to our address.)
    function rescueLostCard(uint256 _cardId, address _recipient) public onlyCEO whenNotPaused {
        require(_owns(this, _cardId));
        _transfer(this, _recipient, _cardId);
    }

    /// @notice Returns the number of cards owned by a specific address.
    /// @dev Required for ERC-721 compliance
    function balanceOf(address _owner) public view returns (uint256 count) {
        return ownershipTokenCount[_owner];
    }    

    /// @notice Transfer a card owned by another address, for which the calling address
    ///  has previously been granted transfer approval by the owner.
    /// @dev Required for ERC-721 compliance.
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    )
        public
        whenNotPaused
    {
        // Check for approval and valid ownership
        require(_approvedFor(msg.sender, _tokenId));
        require(_owns(_from, _tokenId));

        // Reassign ownership (also clears pending approvals and emits Transfer event).
        _transfer(_from, _to, _tokenId);
    }

    /// @notice Returns the total number of cards currently in existence.
    /// @dev Required for ERC-721 compliance.
    function totalSupply() public view returns (uint) {
        return cards.length - 1;
    }

    /// @notice Returns the address currently assigned ownership of a given card.
    /// @dev Required for ERC-721 compliance.
    function ownerOf(uint256 _tokenId)
        public
        view
        returns (address owner)
    {
        owner = cardIndexToOwner[_tokenId];

        require(owner != address(0));
    }

    /// @notice Returns the nth card assigned to an address, with n specified by the
    ///  _index argument.
    /// @dev This method MUST NEVER be called by smart contract code. It will almost
    ///  certainly blow past the block gas limit once there are a large number of
    ///  cards in existence. Exists only to allow off-chain queries of ownership.
    ///  Optional method for ERC-721.
    function tokensOfOwnerByIndex(address _owner, uint256 _index)
        external
        view
        returns (uint256 tokenId)
    {
        uint256 count = 0;
        for (uint256 i = 1; i <= totalSupply(); i++) {
            if (cardIndexToOwner[i] == _owner) {
                if (count == _index) {
                    return i;
                } else {
                    count++;
                }
            }
        }
        revert();
    }

    /// @dev Checks if a given address currently has transferApproval for a particular card.
    function _approvedFor(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return cardIndexToApproved[_tokenId] == _claimant;
    }

    /// @dev Marks an address as being approved for transferFrom(), overwriting any previous
    ///  approval. Setting _approved to address(0) clears all transfer approval.
    ///  NOTE: _approve() does NOT send the Approval event. This is intentional because
    ///  _approve() and transferFrom() are used together for putting cards on auction, and
    ///  there is no value in spamming the log with Approval events in that case.
    function _approve(uint256 _tokenId, address _approved) internal {
        cardIndexToApproved[_tokenId] = _approved;
    }

    /// @notice Grant another address the right to transfer a specific card via
    ///  transferFrom(). This is the preferred flow for transfering NFTs to contracts.
    /// @dev Required for ERC-721 compliance.
    function approve(
        address _to,
        uint256 _tokenId
    )
        public
        whenNotPaused
    {
        // Only an owner can grant transfer approval.
        require(_owns(msg.sender, _tokenId));

        // Register the approval (replacing any previous approval).
        _approve(_tokenId, _to);

        // Emit approval event.
        Approval(msg.sender, _to, _tokenId);
    }

    /// @notice Transfers a card to another address. If transferring to a smart
    ///  contract be VERY CAREFUL to ensure that it is aware of ERC-721 (or
    ///  CryptoCards specifically) or your card may be lost forever. Seriously.
    /// @dev Required for ERC-721 compliance.
    function transfer(
        address _to,
        uint256 _tokenId
    )
        public
        whenNotPaused
    {
        // Safety check to prevent against an unexpected 0x0 default.
        require(_to != address(0));
        // You can only send your own card.
        require(_owns(msg.sender, _tokenId));

        // Reassign ownership, clear pending approvals, emit Transfer event.
        _transfer(msg.sender, _to, _tokenId);
    }
}
