pragma solidity ^0.4.18;

import "./CardAccessControl.sol";


// @title Base contract for Crypto Goddess Cards. Holds all common structs, events and base variables.
// @author Fancy Dorela (goddesscards@hotmail.com)
// @dev See the CardCore contract documentation to understand how the various contract facets are arranged.
contract CardBase is CardAccessControl {
    /*** EVENTS ***/

    // @dev The Create event is fired whenever a new card comes into existence.
    event Create(address indexed owner, uint256 cardId, uint256 mId, uint256 fId, uint128 genes);

    // @dev Transfer event as defined in current draft of ERC721. Emitted every time a card
    //  ownership is assigned, including creation.
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /*** DATA TYPES ***/

    // @dev The main card struct. Every card in CryptoCards is represented by a copy
    //  of this structure, so great care was taken to ensure that it fits neatly into
    //  exactly two 256-bit words. Note that the order of the members in this structure
    //  is important because of the byte-packing rules used by Ethereum.
    struct Card {
        // The Card's genetic code is packed into these 128-bits, which contains 16 parts of gene
        //  refering to different attributes. When card is created, its gene can not change forever.
        uint128 genes;

        // The timestamp from the block when this card is created.
        uint64 createTime;        

        // The ID of the parents of this card, set to 0 for gen0 cards.
        uint32 mId;
        uint32 fId;

        // Set to the ID of the combination.
        uint32 combinationId;
    }
    

    /*** STORAGE ***/            
    // Counts of gen0 card created.
    uint256 public countOfGen0Created;
    // Last block number to create gen0 cards.
    uint public lastGen0BlockNumber = 0;    

    // @dev An array containing the Card struct for all Cards in existence. The ID
    //  of each card is actually an index into this array. Note that ID 0 is Goddess Nuva (Creation Goddess),
    //  which can generate all gen0 cards. 
    Card[] cards;

    // @dev A mapping from card IDs to the address that owns them. All cards have
    //  some valid owner address, even gen0 cards are created with a non-zero owner.
    mapping (uint256 => address) public cardIndexToOwner;

    // @dev A mapping from owner address to count of tokens that address owns.
    //  Used internally inside balanceOf() to resolve ownership count.
    mapping (address => uint256) ownershipTokenCount;

    // @dev A mapping from CardIDs to an address that has been approved to call
    //  transferFrom(). Each card can only have one approved address for transfer
    //  at any time. A zero value means no approval is outstanding.
    mapping (uint256 => address) public cardIndexToApproved;

    // @dev A mapping from CardIDs to an address that has been approved to use
    //  this card for siring via combinateWith(). Each card can only have one approved
    //  address for combination at any time. A zero value means no approval is outstanding.
    mapping (uint256 => address) public combinationAllowedToAddress;

    // Get combination id as sha256(m_id, f_id), and get registered index as the number of blocks when called.
    mapping (uint256 => uint) public combinationRegIndex;

    // @dev Assigns ownership of a specific card to an address.
    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        // since the number of cards is capped to 2^32
        // there is no way to overflow this
        ownershipTokenCount[_to]++;
        // transfer ownership
        cardIndexToOwner[_tokenId] = _to;
        // When creating new cards _from is 0x0, but we can't account that address.
        if (_from != address(0)) {
            ownershipTokenCount[_from]--;
            // once the card is transferred also clear combination allowances
            delete combinationAllowedToAddress[_tokenId];
            // clear any previously approved ownership exchange
            delete cardIndexToApproved[_tokenId];
        }
        // Emit the transfer event.
        Transfer(_from, _to, _tokenId);
    }

    // @dev An internal method that creates a new card and stores it. This
    //  method doesn't do any checking and should only be called when the
    //  input data is known to be valid. Will generate both a Create event
    //  and a Transfer event.
    // @param _mId The card ID of the male part of this card (zero for gen0)
    // @param _fId The card ID of the female part of this card (zero for gen0)
    
    // @param _genes The card's genetic code.
    // @param _owner The inital owner of this card, must be non-zero (except for the Nuwa, ID 0)
    // @param _now 	The time of this card's creation
    function _createCard(
        uint256 _mId,
        uint256 _fId,
        uint128 _genes,
        address _owner,
        uint64 _now
    )
        internal
        returns (uint)
    {
        // These requires are not strictly necessary, our calling code should make
        // sure that these conditions are never broken. However! _createCard() is already
        // an expensive call (for storage), and it doesn't hurt to be especially careful
        // to ensure our data structures are always valid.
        require(_mId <= 4294967295);
        require(_fId <= 4294967295);

        Card memory _card = Card({
            genes: _genes,
            createTime: uint64(_now),            
            mId: uint32(_mId),
            fId: uint32(_fId),
            combinationId: 0
        });
        uint256 newCardId = cards.push(_card) - 1;

        // Make sure provent overflow. 
        // WE DON'T NEED TOO MANY GODDESS AT ALL!
        require(newCardId <= 4294967295);

        // emit the Create event
        Create(
            _owner,
            newCardId,
            uint256(_card.mId),
            uint256(_card.fId),
            _card.genes
        );

        // This will assign ownership, and also emit the Transfer event as
        // per ERC721 draft
        _transfer(0, _owner, newCardId);

        return newCardId;
    }
}
