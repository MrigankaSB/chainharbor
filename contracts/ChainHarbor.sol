// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ChainHarbor
 * @dev A decentralized asset registry for secure ownership and transfer of digital assets.
 */
contract ChainHarbor {
    struct Asset {
        uint256 id;
        string name;
        address owner;
    }

    mapping(uint256 => Asset) public assets;
    uint256 public totalAssets;

    event AssetRegistered(uint256 indexed id, string name, address indexed owner);
    event OwnershipTransferred(uint256 indexed id, address indexed from, address indexed to);

    /**
     * @dev Register a new digital asset.
     * @param _name The name of the asset.
     */
    function registerAsset(string memory _name) public {
        totalAssets++;
        assets[totalAssets] = Asset(totalAssets, _name, msg.sender);
        emit AssetRegistered(totalAssets, _name, msg.sender);
    }

    /**
     * @dev Transfer ownership of an asset to another address.
     * @param _id The ID of the asset.
     * @param _newOwner The address of the new owner.
     */
    function transferOwnership(uint256 _id, address _newOwner) public {
        require(_id > 0 && _id <= totalAssets, "Invalid asset ID");
        Asset storage asset = assets[_id];
        require(asset.owner == msg.sender, "Only owner can transfer asset");
        require(_newOwner != address(0), "Invalid new owner");

        address previousOwner = asset.owner;
        asset.owner = _newOwner;
        emit OwnershipTransferred(_id, previousOwner, _newOwner);
    }

    /**
     * @dev Get details of an asset by its ID.
     * @param _id The ID of the asset.
     * @return id, name, owner of the asset.
     */
    function getAsset(uint256 _id) public view returns (uint256, string memory, address) {
        require(_id > 0 && _id <= totalAssets, "Asset does not exist");
        Asset memory asset = assets[_id];
        return (asset.id, asset.name, asset.owner);
    }
}

